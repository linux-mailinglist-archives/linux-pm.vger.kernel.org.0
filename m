Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7533C364CD4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 23:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhDSVJb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhDSVJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 17:09:31 -0400
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Apr 2021 14:09:00 PDT
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A862C06174A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 14:09:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D71541F538;
        Mon, 19 Apr 2021 22:59:48 +0200 (CEST)
Subject: Re: [PATCH v4 5/7] cpufreq: qcom-hw: Implement CPRh aware OSM
 programming
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-6-angelogioacchino.delregno@somainline.org>
 <20210419185203.GQ1538589@yoga>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <e486d752-b99a-3479-b2ae-b37cdb3edd9a@somainline.org>
Date:   Mon, 19 Apr 2021 22:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210419185203.GQ1538589@yoga>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 19/04/21 20:52, Bjorn Andersson ha scritto:
> On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:
> 
>> On new SoCs (SDM845 onwards) the Operating State Manager (OSM) is
>> being programmed in the bootloader and write-protected by the
>> hypervisor, leaving to the OS read-only access to some of its
>> registers (in order to read the Lookup Tables and also some
>> status registers) and write access to the p-state register, for
>> for the OS to request a specific performance state to trigger a
>> DVFS switch on the CPU through the OSM hardware.
>>
>> On old SoCs though (MSM8998, SDM630/660 and variants), the
>> bootloader will *not* initialize the OSM (and the CPRh, as it
>> is a requirement for it) before booting the OS, making any
>> request to trigger a performance state change ineffective, as
>> the hardware doesn't have any Lookup Table, nor is storing any
>> parameter to trigger a DVFS switch. In this case, basically all
>> of the OSM registers are *not* write protected for the OS, even
>> though some are - but write access is granted through SCM calls.
>>
>> This commit introduces support for OSM programming, which has to
>> be done on these old SoCs that were distributed (almost?) always
>> with a bootloader that does not do any CPRh nor OSM init before
>> booting the kernel.
>> In order to program the OSM on these SoCs, it is necessary to
>> fullfill a "special" requirement: the Core Power Reduction
>> Hardened (CPRh) hardware block must be initialized, as the OSM
>> is "talking" to it in order to perform the Voltage part of DVFS;
>> here, we are calling initialization of this through Linux generic
>> power domains, specifically by requesting a genpd attach from the
>> qcom-cpufreq-hw driver, which will give back voltages associated
>> to each CPU frequency that has been declared in the OPPs, scaled
>> and interpolated with the previous one, and will also give us
>> parameters for the Array Power Mux (APM) and mem-acc, in order
>> for this driver to be then able to generate the Lookup Tables
>> that will be finally programmed to the OSM hardware.
>>
>> After writing the parameters to the OSM and enabling it, all the
>> programming work will never happen anymore until a OS reboot, so
>> all of the allocations and "the rest" will be disposed-of: this
>> is done mainly to leave the code that was referred only to the
>> new SoCs intact, as to also emphasize on the fact that the OSM
>> HW is, in the end, the exact same; apart some register offsets
>> that are slightly different, the entire logic is the same.
>>
>> This also adds the parameters to support CPU scaling on SDM630
>> and MSM8998.
>>
> 
> Thank you for the patch Angelo and sorry for postponing the review for
> so long. I'm now convinced that your approach of extending this driver
> is the right one.
> 

No problem Bjorn, this was a very large patchset (in terms of both logic 
and code size) to review. I totally appreciate your coming back to it, 
even if later rather than sooner.

> Some comments on the implementation though.
> 
> @Viresh, do you have any suggestion regarding my last comment?
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 1240 ++++++++++++++++++++++++++++-
>>   1 file changed, 1208 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index acc645b85e79..a92959bb7b50 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -1,33 +1,256 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + *
>> + * OSM hardware initial programming
>> + * Copyright (C) 2020, AngeloGioacchino Del Regno
>> + *                     <angelogioacchino.delregno@somainline.org>
>>    */
>>   
>>   #include <linux/bitfield.h>
>>   #include <linux/cpufreq.h>
>> +#include <linux/delay.h>
>>   #include <linux/init.h>
>>   #include <linux/interconnect.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/slab.h>
>> +#include <linux/qcom_scm.h>
>>   
>>   #define LUT_MAX_ENTRIES			40U
>> -#define LUT_SRC				GENMASK(31, 30)
>> +#define LUT_SRC_845			GENMASK(31, 30)
>> +#define LUT_SRC_8998			GENMASK(27, 26)
>> +#define LUT_PLL_DIV			GENMASK(25, 24)
>>   #define LUT_L_VAL			GENMASK(7, 0)
>>   #define LUT_CORE_COUNT			GENMASK(18, 16)
>> +#define LUT_VOLT_VC			GENMASK(21, 16)
>>   #define LUT_VOLT			GENMASK(11, 0)
>> -#define CLK_HW_DIV			2
>>   #define LUT_TURBO_IND			1
>> +#define OSM_BOOT_TIME_US		5
>> +
>> +#define CYCLE_COUNTER_CLK_RATIO		GENMASK(5, 1)
>> +#define OSM_XO_RATIO_VAL		(10 - 1)
>> +#define CYCLE_COUNTER_USE_XO_EDGE	BIT(8)
>> +
>> +/* FSM Boost Control */
>> +#define CC_BOOST_EN			BIT(0)
>> +#define PS_BOOST_EN			BIT(1)
>> +#define DCVS_BOOST_EN			BIT(2)
>> +#define BOOST_TIMER_REG_HI		GENMASK(31, 16)
>> +#define BOOST_TIMER_REG_LO		GENMASK(15, 0)
>> +
>> +#define PLL_WAIT_LOCK_TIME_NS		2000
>> +#define SAFE_FREQ_WAIT_NS		1000
>> +#define DEXT_DECREMENT_WAIT_NS		200
>> +
>> +#define BOOST_SYNC_DELAY		5
>> +
>> +#define HYSTERESIS_UP_MASK		GENMASK(31, 16)
>> +#define HYSTERESIS_DN_MASK		GENMASK(15, 0)
>> +#define HYSTERESIS_CC_NS		200
>> +#define HYSTERESIS_LLM_NS		65535
>> +
>> +/* FSM Droop Control */
>> +#define PC_RET_EXIT_DROOP_EN		BIT(3)
>> +#define WFX_DROOP_EN			BIT(4)
>> +#define DCVS_DROOP_EN			BIT(5)
>> +#define DROOP_TIMER1			GENMASK(31, 16)
>> +#define DROOP_TIMER0			GENMASK(15, 0)
>> +#define DROOP_CTRL_VAL			(BIT(3) | BIT(17) | BIT(31))
>> +#define DROOP_TIMER_NS			100
>> +#define DROOP_WAIT_RELEASE_TIMER_NS	50
>> +#define DROOP_RELEASE_TIMER_NS		1
>> +
>> +/* PLL Override Control */
>> +#define PLL_OVERRIDE_DROOP_EN		BIT(0)
>> +
>> +/* Sequencer */
>> +#define SEQUENCER_REG(base, n)		(base + (n * 4))
>> +#define SEQ_APM_THRESH_VC		15
>> +#define SEQ_APM_THRESH_PREVC		31
>> +#define SEQ_MEM_ACC_LVAL		32
>> +#define SEQ_MEM_ACC_0			55
>> +#define SEQ_APM_CROSSOVER_VC		72
>> +#define SEQ_APM_PARAM			76
>> +#define SEQ_MEM_ACC_CROSSOVER_VC	88
>> +#define SEQ_MEM_ACC_MAX_LEVELS		4
>> +#define SEQ_MEMACC_REG(base, n)		SEQUENCER_REG(base, SEQ_MEM_ACC_0 + n)
>> +
>> +/* ACD */
>> +#define ACD_WRITE_CTL_UPDATE_EN		BIT(0)
>> +#define ACD_WRITE_CTL_SELECT_SHIFT	1
>> +
>> +/**
>> + * struct qcom_cpufreq_soc_setup_data - Register offsets for OSM setup
>> + *
>> + * @reg_osm_sequencer:      OSM Sequencer (used to get physical address)
>> + * @reg_override:           Override parameters
>> + * @reg_spare:              Spare parameters (MEMACC-to-VC)
>> + * @reg_cc_zero_behav:      Virtual Corner for cluster power collapse
>> + * @reg_spm_cc_hyst:        DCVS-CC Wait time for frequency inc/decrement
>> + * @reg_spm_cc_dcvs_dis:    DCVS-CC en/disable control
>> + * @reg_spm_core_ret_map:   Treat cores in retention as active/inactive
>> + * @reg_llm_freq_vote_hyst: DCVS-LLM Wait time for frequency inc/decrement
>> + * @reg_llm_volt_vote_hyst: DCVS-LLM Wait time for voltage inc/decrement
>> + * @reg_llm_intf_dcvs_dis:  DCVS-LLM en/disable control
>> + * @reg_seq1:               Sequencer extra register
>> + * @reg_pdn_fsm_ctrl:       Boost and Droop FSMs en/disable control
>> + * @reg_cc_boost_timer:     CC-Boost FSM wait first timer register
>> + * @reg_dcvs_boost_timer:   DCVS-Boost FSM wait first timer register
>> + * @reg_ps_boost_timer:     PS-Boost FSM wait first timer register
>> + * @boost_timer_reg_len:    Length of boost timer registers
>> + * @reg_boost_sync_delay:   PLL signal timing control for Boost
>> + * @reg_droop_ctrl:         Droop control value
>> + * @reg_droop_release_ctrl: Wait for Droop release
>> + * @reg_droop_unstall_ctrl: Wait for Droop unstall
>> + * @reg_droop_wait_release_ctrl: Time to wait for state release
>> + * @reg_droop_timer_ctrl:   Droop timer
>> + * @reg_droop_sync_delay:   PLL signal timing control for Droop
>> + * @reg_pll_override:       PLL Droop Override en/disable control
>> + * @reg_cycle_counter:      OSM CPU cycle counter
>> + *
>> + * This structure holds the register offsets that are used to set-up
>> + * the Operating State Manager (OSM) parameters, when it is not (or
>> + * not entirely) configured from the bootloader and TrustZone.
>> + *
>> + * Acronyms used in this documentation:
>> + * CC = Core Count
>> + * PS = Power-Save
>> + * VC = Virtual Corner
>> + * LLM = Limits Load Management
>> + * DCVS = Dynamic Clock and Voltage Scaling
>> + */
>> +struct qcom_cpufreq_soc_setup_data {
>> +	/* OSM phys register offsets */
>> +	u16 reg_osm_sequencer;
>> +
>> +	/* Frequency domain register offsets */
>> +	u16 reg_override;
>> +	u16 reg_spare;
>> +	u16 reg_cc_zero_behav;
>> +	u16 reg_spm_cc_hyst;
>> +	u16 reg_spm_cc_dcvs_dis;
>> +	u16 reg_spm_core_ret_map;
>> +	u16 reg_llm_freq_vote_hyst;
>> +	u16 reg_llm_volt_vote_hyst;
>> +	u16 reg_llm_intf_dcvs_dis;
>> +	u16 reg_seq1;
>> +	u16 reg_pdn_fsm_ctrl;
>> +	u16 reg_cc_boost_timer;
>> +	u16 reg_dcvs_boost_timer;
>> +	u16 reg_ps_boost_timer;
>> +	u16 boost_timer_reg_len;
>> +	u16 reg_boost_sync_delay;
>> +	u16 reg_droop_ctrl;
>> +	u16 reg_droop_release_ctrl;
>> +	u16 reg_droop_unstall_ctrl;
>> +	u16 reg_droop_wait_release_ctrl;
>> +	u16 reg_droop_timer_ctrl;
>> +	u16 reg_droop_sync_delay;
>> +	u16 reg_pll_override;
>> +	u16 reg_cycle_counter;
>> +};
>> +
>> +/**
>> + * struct qcom_cpufreq_soc_acd_data - Adaptive Clock Distribution data
>> + *
>> + * @tl_delay_reg:      Tunable-Length Delay (TLD) register offset
>> + * @acd_ctrl_reg:      Control Register (CR) register offset
>> + * @softstart_reg:     Soft Start Control Register (SSCR) register offset
>> + * @ext_intf_reg:      External interface configuration register offset
>> + * @auto_xfer_reg:     Auto Register-Transfer register offset
>> + * @auto_xfer_cfg_reg: Auto Register-Transfer Configuration reg offset
>> + * @auto_xfer_ctl_reg: Auto Register-Transfer Control register offset
>> + * @auto_xfer_sts_reg: Auto Register-Transfer Status register offset
>> + * @dcvs_sw_reg:       Software DCVS register offset
>> + * @gfmux_cfg_reg:     Glitch-Free MUX configuration register offset
>> + * @write_ctl_reg:     Write Control register
>> + * @write_sts_reg:     Write Status register
>> + * @tl_delay_val:      Tunable-Length Delay (TLD) value
>> + * @acd_ctrl_val:      Control Register (CR) value
>> + * @softstart_val:     Soft Start Control Register (SSCR) value
>> + * @ext_intf0_val:     Initial external interface configuration value
>> + * @ext_intf1_val:     Final external interface configuration value
>> + * @auto_xfer_val:     Auto-register Transfer Control value
>> + *
>> + * This structure holds the register offsets (from the ACD iospace base)
>> + * and the parameters that are required to configure the OSM to
>> + * initialize the Adaptive Clock Distribution (ACD) system.
>> + */
>> +struct qcom_cpufreq_soc_acd_data {
>> +	u8 tl_delay_reg;
>> +	u8 acd_ctrl_reg;
>> +	u8 softstart_reg;
>> +	u8 ext_intf_reg;
>> +	u8 auto_xfer_reg;
>> +	u8 auto_xfer_cfg_reg;
>> +	u8 auto_xfer_ctl_reg;
>> +	u8 auto_xfer_sts_reg;
>> +	u8 dcvs_sw_reg;
>> +	u8 gfmux_cfg_reg;
>> +	u8 write_ctl_reg;
>> +	u8 write_sts_reg;
>> +	u32 tl_delay_val;
>> +	u32 acd_ctrl_val;
>> +	u32 softstart_val;
>> +	u32 ext_intf0_val;
>> +	u32 ext_intf1_val;
>> +	u32 auto_xfer_val;
>> +};
>> +
>> +/**
>> + * struct qcom_cpufreq_hw_params - Operating State Manager (OSM) Parameters
>> + *
>> + * @volt_lut_val: Value composed of: virtual corner (vc) and voltage in mV.
>> + * @freq_lut_val: Value composed of: core count, clock source and output
>> + *                frequency in MHz.
>> + * @override_val: PLL parameters that the OSM uses to override the previous
>> + *                setting coming from the bootloader, or when uninitialized.
>> + * @spare_val:    Spare register, used by both this driver and the OSM HW
>> + *                to identify MEM-ACC levels in relation to virtual corners.
>> + * @acc_thresh:   MEM-ACC threshold level
>> + *
>> + * This structure holds the parameters to write to the OSM registers for
>> + * one "Virtual Corner" (VC), or one Performance State (p-state).
>> + */
>> +struct qcom_cpufreq_hw_params {
>> +	u32 volt_lut_val;
>> +	u32 freq_lut_val;
>> +	u32 override_val;
>> +	u32 spare_val;
>> +	u32 acc_thresh;
>> +};
>>   
>> +/**
>> + * struct qcom_cpufreq_soc_data - SoC specific register offsets of the OSM
>> + *
>> + * @reg_enable:            OSM enable status
>> + * @reg_index:             Index of the Virtual Corner
>> + * @reg_freq_lut:          Frequency Lookup Table
>> + * @reg_freq_lut_src_mask: Frequency Lookup Table clock-source mask
>> + * @reg_volt_lut:          Voltage Lookup Table
>> + * @reg_perf_state:        Performance State request register
>> + * @lut_row_size:          Lookup Table row size
>> + * @clk_hw_div:            Divider for "alternate" OSM clock-source
>> + * @uses_tz:               OSM already set-up and protected by TrustZone
>> + * @setup_regs:            Register offsets for OSM setup
>> + */
>>   struct qcom_cpufreq_soc_data {
>>   	u32 reg_enable;
>> +	u32 reg_index;
>>   	u32 reg_freq_lut;
>> +	u32 reg_freq_lut_src_mask;
>>   	u32 reg_volt_lut;
>>   	u32 reg_perf_state;
>> -	u8 lut_row_size;
>> +	u8  lut_row_size;
> 
> You don't column-align members in the structs above, and if you skip
> that here as well you would avoid the whitespace change.
> 

Yes, I completely agree.

>> +	u8  clk_hw_div;
>> +	bool uses_tz;
>> +	const struct qcom_cpufreq_soc_setup_data setup_regs;
>> +	const struct qcom_cpufreq_soc_acd_data acd_data;
>>   };
>>   
>>   struct qcom_cpufreq_data {
>> @@ -35,9 +258,17 @@ struct qcom_cpufreq_data {
>>   	const struct qcom_cpufreq_soc_data *soc_data;
>>   };
>>   
>> -static unsigned long cpu_hw_rate, xo_rate;
>> +static const char *cprh_genpd_names[] = { "cprh", NULL };
>> +static u64 cpu_hw_rate, xo_rate;
> 
> The clock API returns cpu_hw_rate and xo_rate as unsigned long and
> the only math done seems to reduce the number of bits used. So why this
> change?
> 

That was probably done in one of these moments in which you go 
completely crazy over your own code... yeah that needs to be changed 
back to unsigned long.

>>   static bool icc_scaling_enabled;
>>   
>> +/**
>> + * qcom_cpufreq_set_bw - Set interconnect bandwidth
> 
> Functions in kerneldoc should include the ()
> 
> I really like the kerneldoc additions, but think they are separate from
> the addition of the initialization logic, could you please spin them out
> in a separate patch?
> 

Roger that.

>> + * @policy:   CPUFreq policy structure
>> + * @freq_khz: CPU Frequency in KHz
>> + *
>> + * Returns: Zero for success, otherwise negative value on errors
>> + */
>>   static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
>>   			       unsigned long freq_khz)
>>   {
>> @@ -59,6 +290,20 @@ static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
>>   	return ret;
>>   }
>>   
>> +/**
>> + * qcom_cpufreq_update_opp - Update CPU OPP tables
>> + * @policy:   CPUFreq policy structure
>> + * @freq_khz: CPU Frequency for OPP entry in KHz
>> + * @volt:     CPU Voltage for OPP entry in microvolts
>> + *
>> + * The CPU frequencies and voltages are being read from the Operating
>> + * State Manager (OSM) and the related OPPs, read from DT, need to be
>> + * updated to reflect what the hardware will set for each p-state.
>> + * If there is no OPP table specified in DT, then this function will
>> + * add dynamic ones.
>> + *
>> + * Returns: Zero for success, otherwise negative value on errors
>> + */
>>   static int qcom_cpufreq_update_opp(struct device *cpu_dev,
>>   				   unsigned long freq_khz,
>>   				   unsigned long volt)
>> @@ -79,6 +324,17 @@ static int qcom_cpufreq_update_opp(struct device *cpu_dev,
>>   	return dev_pm_opp_enable(cpu_dev, freq_hz);
>>   }
>>   
>> +/**
>> + * qcom_cpufreq_hw_target_index - Set frequency/voltage
>> + * @policy:   CPUFreq policy structure
>> + * @index:    Performance state index to be set
>> + *
>> + * This function sends a request to the Operating State Manager
>> + * to set a Performance State index, so, to set frequency and
>> + * voltage for the target CPU/cluster.
>> + *
>> + * Returns: Always zero
>> + */
>>   static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>>   					unsigned int index)
>>   {
>> @@ -94,6 +350,12 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * qcom_cpufreq_hw_get - Get current Performance State from OSM
>> + * @cpu:      CPU number
>> + *
>> + * Returns: Current CPU/Cluster frequency or zero
>> + */
>>   static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>>   {
>>   	struct qcom_cpufreq_data *data;
>> @@ -127,6 +389,644 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>>   	return policy->freq_table[index].frequency;
>>   }
>>   
>> +static void qcom_cpufreq_hw_boost_setup(void __iomem *timer0_addr, u32 len)
>> +{
>> +	u32 val;
>> +
>> +	/* timer_reg0 */
>> +	val = FIELD_PREP(BOOST_TIMER_REG_LO, PLL_WAIT_LOCK_TIME_NS);
>> +	val |= FIELD_PREP(BOOST_TIMER_REG_HI, SAFE_FREQ_WAIT_NS);
>> +	writel_relaxed(val, timer0_addr);
> 
> Throughout the patch you're using _relaxed accessors, even though this
> isn't performance critical. Can you please use writel() and readl()
> directly, unless there's a good reason for the _relaxed versions.
> 

That was a paranoid performance optimization tentative. So much paranoid 
that it doesn't make a lot of sense, effectively.

Will change to non-relaxed versions.

>> +
>> +	/* timer_reg1 */
>> +	val = FIELD_PREP(BOOST_TIMER_REG_LO, PLL_WAIT_LOCK_TIME_NS);
>> +	val |= FIELD_PREP(BOOST_TIMER_REG_HI, PLL_WAIT_LOCK_TIME_NS);
>> +	writel_relaxed(val, timer0_addr + len);
>> +
>> +	/* timer_reg2 */
>> +	val = FIELD_PREP(BOOST_TIMER_REG_LO, DEXT_DECREMENT_WAIT_NS);
>> +	writel_relaxed(val, timer0_addr + (2 * len));
>> +}
>> +
>> +/*
>> + * qcom_cpufreq_gen_params - Generate parameters to send to the hardware
>> + * @cpu_dev:   CPU device
>> + * @data:      SoC specific register offsets
>> + * @hw_tbl:    Pointer to return the array of parameters
>> + * @apm_vc:    APM Virtual Corner crossover number, returned to the caller
>> + * @acc_vc:    MEMACC Virtual Corner crossover number, returned to the caller
>> + * @cpu_count: Number of CPUs in the frequency domain
>> + *
>> + * This function allocates a 'qcom_cpufreq_hw_params' parameters table,
>> + * fills it and returns it to the consumer, ready to get sent to the HW.
>> + * Since the APM threshold is just one
>> + * Freeing the table after usage is left to the caller.
>> + *
>> + * Returns: Number of allocated (and filled) elements in the table,
>> + *          otherwise negative value on errors.
>> + */
>> +static int qcom_cpufreq_gen_params(struct device *cpu_dev,
>> +				   struct qcom_cpufreq_data *data,
>> +				   struct qcom_cpufreq_hw_params **hw_tbl,
>> +				   int *apm_vc, int *acc_vc, int cpu_count)
>> +{
>> +	struct platform_device *pdev = cpufreq_get_driver_data();
>> +	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
>> +	struct device **opp_virt_dev;
>> +	struct opp_table *genpd_opp_table;
>> +	struct dev_pm_opp *apm_opp, *acc_opp;
>> +	unsigned long apm_uV, acc_uV, rate;
>> +	int i, gpd_opp_cnt, ret;
>> +	u8 last_acc_corner = 0, prev_spare = 0;
>> +
>> +	/*
>> +	 * Install the OPP table that we get from DT here already,
>> +	 * otherwise it gets really messy as we'd have to manually walk
>> +	 * through the entire OPP DT, manually find frequencies and
>> +	 * also manually exclude supported-hw (for speed-binning).
>> +	 * This also makes it easier for the genpd to add info in it.
>> +	 */
>> +	ret = dev_pm_opp_of_add_table(cpu_dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Cannot install CPU OPP table: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Get a handle to the genpd virtual device */
>> +	genpd_opp_table = dev_pm_opp_attach_genpd(cpu_dev, cprh_genpd_names,
>> +						  &opp_virt_dev);
> 
> Afaict this happens every time we bring a CPU online, is that
> appropriate?
> 

This happens for each CPU for which we want to write the LUT (as this is 
called only in the function that is responsible to write the LUT).
It should in theory happen every time we bring a CPU online and I agree 
but that's happening for reasons that I don't remember in a very clear way.

I will still throw here what I remember about this, which is that the 
CPR-Hardened driver would probe after the CPUs bringup, hence the PD is 
not getting attached automagically.
This brought the need to poke it when needed - as the CPR driver will 
fill in the OPPs at attach time - and we need to retrieve that data from 
this driver (as we are writing it to the OSM).

What I clearly remember, though, was that this part drove me completely 
crazy, as it was very very hard to make them interact properly (and had 
to completely reimplement it for something like 3-4 times).

What a journey.

>> +	if (IS_ERR(genpd_opp_table)) {
>> +		ret = PTR_ERR(genpd_opp_table);
>> +		if (ret != -EPROBE_DEFER)
> 
> This is being called from cpufreq_driver->init, so afaict EPROBE_DEFER
> isn't going to be a good thing to return. You have the check in probe to
> deal with this and I think you should print an error if you're hitting
> it here.
> 

Indeed. The call to dev_pm_opp_attach_genpd initially was in the probe 
function... I have then transferred it here to solve a race condition 
that I was experiencing.

Useless to say that, as you saw, I forgot to change that check... :(
Even more useless to say that I will definitely fix that.

>> +			dev_err(&pdev->dev,
>> +				"Could not attach to pm_domain: %d\n", ret);
>> +		goto opp_dispose;
>> +	}
>> +
>> +	/* Get the count of available OPPs coming from the power domain */
>> +	gpd_opp_cnt = dev_pm_opp_get_opp_count(cpu_dev);
>> +	if (gpd_opp_cnt < 2) {
>> +		ret = gpd_opp_cnt > 0 ? -EINVAL : gpd_opp_cnt;
>> +		goto detach_gpd;
>> +	}
>> +
>> +	/* Find the APM threshold disabled OPP and "annotate" the voltage */
>> +	apm_opp = dev_pm_opp_find_freq_exact(cpu_dev, 0, false);
>> +	if (IS_ERR(apm_opp)) {
>> +		ret = -EINVAL;
>> +		goto detach_gpd;
>> +	}
>> +
>> +	/* If we get no APM voltage, the system is going to be unstable */
>> +	apm_uV = dev_pm_opp_get_voltage(apm_opp);
>> +	if (apm_uV == 0) {
>> +		ret = -EINVAL;
>> +		goto detach_gpd;
>> +	}
>> +	*apm_vc = -1;
>> +
>> +	/*
>> +	 * Find the ACC threshold disabled OPP and "annotate" the voltage:
>> +	 * this is optional, as not every SoC needs it.
>> +	 */
>> +	acc_opp = dev_pm_opp_find_freq_exact(cpu_dev, 1, false);
>> +	if (IS_ERR(acc_opp)) {
>> +		acc_uV = ULONG_MAX;
>> +		*acc_vc = U8_MAX;
>> +	} else {
>> +		/*
>> +		 * If the ACC OPP is present, this means that we *have* to
>> +		 * set the relative corner on the OSM: if we cannot get the
>> +		 * voltage at that point, the CPU will inevitably freeze.
>> +		 */
>> +		acc_uV = dev_pm_opp_get_voltage(acc_opp);
>> +		if (acc_uV == 0) {
>> +			ret = -EINVAL;
>> +			goto detach_gpd;
>> +		}
>> +		*acc_vc = -1;
>> +	}
>> +
>> +	*hw_tbl = devm_kmalloc_array(&pdev->dev, gpd_opp_cnt,
>> +				     sizeof(**hw_tbl), GFP_KERNEL);
>> +	if (!hw_tbl) {
>> +		ret = -ENOMEM;
>> +		goto detach_gpd;
>> +	}
>> +
>> +	for (i = 0, rate = 0; ; rate++, i++) {
>> +		struct qcom_cpufreq_hw_params *entry = *hw_tbl + i;
>> +		struct dev_pm_opp *genpd_opp;
>> +		struct device_node *np;
>> +		u32 pll_div, millivolts, f_src;
>> +
>> +		/* Find the next enabled OPP's frequency (ignores APM/ACC) */
>> +		genpd_opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>> +		if (IS_ERR(genpd_opp))
>> +			break;
>> +
>> +		/* Get mandatory and optional properties from the OPP DT */
>> +		np = dev_pm_opp_get_of_node(genpd_opp);
>> +		if (!np)
>> +			break;
>> +
>> +		if (of_property_read_u32(np, "qcom,pll-override",
>> +					 &entry->override_val)) {
>> +			of_node_put(np);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (of_property_read_u32(np, "qcom,spare-data",
>> +					 &entry->spare_val))
>> +			entry->spare_val = 0;
>> +
>> +		if (of_property_read_u32(np, "qcom,pll-div", &pll_div))
>> +			pll_div = 0;
>> +
>> +		of_node_put(np);
>> +
>> +		/* Get voltage in microvolts, then convert to millivolts */
>> +		millivolts = dev_pm_opp_get_voltage(genpd_opp);
>> +		if (millivolts >= apm_uV && *apm_vc < 0)
>> +			*apm_vc = i;
>> +		if (millivolts >= acc_uV && *acc_vc < 0)
>> +			*acc_vc = i;
>> +
>> +		millivolts /= 1000;
>> +
>> +		if (millivolts < 150 || millivolts > 1400) {
>> +			dev_err(&pdev->dev,
>> +				"Read invalid voltage: %u.\n", millivolts);
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* In the OSM firmware, "Virtual Corner" levels start from 0 */
>> +		entry->volt_lut_val = FIELD_PREP(LUT_VOLT_VC, i);
>> +		entry->volt_lut_val |= FIELD_PREP(LUT_VOLT, millivolts);
>> +
>> +		/* Only the first frequency can have alternate source */
>> +		f_src = i ? 1 : 0;
>> +		f_src <<= ffs(soc_data->reg_freq_lut_src_mask) - 1;
>> +		entry->freq_lut_val = f_src | div_u64(rate, xo_rate);
>> +		entry->freq_lut_val |= FIELD_PREP(LUT_CORE_COUNT, cpu_count);
>> +
>> +		/*
>> +		 * PLL divider is not always 0 and there is no way to determine
>> +		 * it automatically, as setting this value higher than DIV1
>> +		 * will make the OSM HW to effectively set the PLL at 2-4x
>> +		 * the CPU frequency and then divide the CPU clock by this div,
>> +		 * so this value is effectively used as both a multiplier and
>> +		 * divider.
>> +		 * This value cannot be calculated because it depends on
>> +		 * manual calibration and is (most probably) used to choose
>> +		 * a PLL frequency that gives the least possible jitter.
>> +		 */
>> +		entry->freq_lut_val |= FIELD_PREP(LUT_PLL_DIV, pll_div);
>> +
>> +		/*
>> +		 * MEM-ACC Virtual Corner threshold voltage: set the
>> +		 * acc_thresh to the "next different" spare_val, otherwise
>> +		 * set it to an invalid value, so that we can recognize it
>> +		 * and exclude it later, when this set of data will be used
>> +		 * for programming the OSM.
>> +		 */
>> +		if (entry->spare_val != prev_spare) {
>> +			prev_spare = entry->spare_val;
>> +			entry->acc_thresh = last_acc_corner;
> 
> last_acc_corner is never modified from it's constant value of 0.
> 

I have to recheck this part: the driver was working perfectly (hence 
programming the OSM perfectly) on various smartphones I tried, but this 
looks odd right now.

The entire acc_thresh seems to be unused and it should be a leftover 
from a previous structure model... if I recall that correctly, this was 
a logic mistake, as this was used downstream for the cases in which the 
TZ wasn't doing any partial programming (and not setting *any* security 
up at all on the OSM), but then that logic was apparently belonging to 
some pre-sil stage or early firmware that was never shipped on 8998.

This has to be removed, as it's not applicable to the target HW of this 
patch series and I'm sure that nobody will ever need this piece of logic 
(or in any case, I'm not aware of any OSM that's fully free from TZ on 
any released chip - and even if I was, I don't have any).

Before removing - anyway - I will find time to recheck it carefully.


>> +		} else {
>> +			entry->acc_thresh = SEQ_MEM_ACC_MAX_LEVELS + 1;
>> +		}
>> +
>> +		dev_dbg(&pdev->dev,
>> +			"[%d] freq=0x%x volt=0x%x override=0x%x spare=0x%x\n",
>> +			i, entry->freq_lut_val, entry->volt_lut_val,
>> +			entry->override_val, entry->spare_val);
>> +		dev_pm_opp_put(genpd_opp);
>> +	}
>> +
>> +	/*
>> +	 * If we've got a customized mem-acc corner but we couldn't
>> +	 * find any suitable crossover, or the corner is less than
>> +	 * the minimum amount of required corners for mem-acc scaling,
>> +	 * the values are not valid, hence fall back to LUT values.
>> +	 */
>> +	if (acc_uV != ULONG_MAX && *acc_vc < SEQ_MEM_ACC_MAX_LEVELS - 1) {
>> +		dev_dbg(&pdev->dev,
>> +			"MEM-ACC corner: invalid values VC%d %luuV\n",
>> +			*acc_vc, acc_uV);
>> +		*acc_vc = U8_MAX;
>> +	}
>> +
>> +	/*
>> +	 * If we have probed less params than what we need, then the
>> +	 * OPP table that we got from the genpd is malformed for some
>> +	 * reason: in this case, do not apply the table to the HW.
>> +	 */
>> +	if (i < gpd_opp_cnt) {
>> +		dev_err(&pdev->dev, "Got bad OPP table from power domain.\n");
>> +		ret = -EINVAL;
>> +		goto detach_gpd;
>> +	}
>> +
>> +detach_gpd:
>> +	dev_pm_opp_detach_genpd(genpd_opp_table);
>> +opp_dispose:
>> +	/*
>> +	 * Now that we're totally done with it, dispose of all the dynamic
>> +	 * OPPs in the table: like this, at the end of the OSM configuration
>> +	 * we are leaving it like it was magically configured by the TZ or
>> +	 * by the bootloader and using the rest of the driver as if this
>> +	 * programming phase has never happened in the OS, like new SoCs.
>> +	 * This also makes us able to not modify a single bit in the basic
>> +	 * OSM frequency request logic that was meant for the newest SoCs.
>> +	 */
>> +	dev_pm_opp_remove_all_dynamic(cpu_dev);
>> +	return ret < 0 ? ret : i;
>> +}
>> +
>> +static inline u32 qcom_cpufreq_acd_regbit(u8 acd_reg_offset)
>> +{
>> +	return BIT((acd_reg_offset / 4));
> 
> Unnecessary double parenthesis.
> 

Yeah... will fix :))

>> +}
>> +
>> +static int qcom_cpufreq_hw_acd_write_autoxfer(struct qcom_cpufreq_data *data,
>> +					      void __iomem *acd_base, u32 val)
>> +{
>> +	const struct qcom_cpufreq_soc_data *sdata = data->soc_data;
>> +	const struct qcom_cpufreq_soc_acd_data *aregs = &sdata->acd_data;
>> +	u32 regval;
>> +	int retry = 3;
>> +
>> +	writel_relaxed(val, acd_base + aregs->auto_xfer_cfg_reg);
>> +
>> +	/* (Clear, then) Set AUTOXFER START */
>> +	writel_relaxed(0, acd_base + aregs->auto_xfer_reg);
>> +	writel_relaxed(1, acd_base + aregs->auto_xfer_reg);
>> +
>> +	/* Poll for status: if the first bit is set the transfer is done. */
>> +	do {
>> +		regval = readl_relaxed(acd_base + aregs->auto_xfer_sts_reg);
>> +		if (regval & BIT(0))
>> +			break;
>> +		udelay(1);
>> +	} while (--retry);
> 
> I know it's only for 3uS, but please use readl_poll_timeout() instead -
> which already has the appropriate return value.
> 

Sure, will do, on this and all the other occurences :)))
P.S.: This succeeds at the first read in 99% of the cases, anyway!

>> +
>> +	if (retry <= 0)
>> +		return -ETIMEDOUT;
>> +	return 0;
>> +}
>> +
>> +static int qcom_cpufreq_hw_acd_write_xfer(struct qcom_cpufreq_data *data,
>> +					  void __iomem *acd_base, u8 reg,
>> +					  u32 val)
>> +{
>> +	const struct qcom_cpufreq_soc_data *sdata = data->soc_data;
>> +	const struct qcom_cpufreq_soc_acd_data *aregs = &sdata->acd_data;
>> +	int retry = 2;
>> +	u32 regval;
>> +
>> +	/* Write to the register, then initiate manual transfer */
>> +	writel_relaxed(val, acd_base + reg);
>> +
>> +	/*
>> +	 * Make sure that the write goes through, otherwise the local
>> +	 * transfer process will wrongly copy the old value.
>> +	 */
> 
> The wmb() ensures ordering, not that the write has gone through. If this
> is sufficient you should be able to use writel() and avoid having to
> comment on it.
> 

And writel() will be.

>> +	wmb();
>> +
>> +	/* Clear write control register */
>> +	writel_relaxed(0, acd_base + aregs->write_ctl_reg);
>> +
>> +	regval = (reg / 4) << ACD_WRITE_CTL_SELECT_SHIFT;
>> +	regval |= ACD_WRITE_CTL_UPDATE_EN;
>> +	writel_relaxed(regval, acd_base + aregs->write_ctl_reg);
>> +
>> +	/* Wait until ACD Local Transfer is done */
>> +	do {
>> +		regval = readl_relaxed(acd_base + aregs->write_sts_reg);
>> +		if (regval & qcom_cpufreq_acd_regbit(reg))
>> +			break;
>> +		udelay(1);
>> +	} while (--retry);
> 
> Another readl_poll_timeout().
> 
>> +
>> +	if (retry <= 0)
>> +		return -ETIMEDOUT;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qcom_cpufreq_hw_acd_init - Initialize ACD params in the OSM
>> + * @cpu_dev:   CPU device
>> + * @policy:    CPUFreq policy structure
>> + * @index:     Instance number (CPU cluster number)
>> + *
>> + * On some SoCs it is required to send the ACD configuration parameters
>> + * to the OSM. This function takes the parameters from the SoC specific
>> + * configuration and writes them only if a "osm-acdN" iospace has been
>> + * declared (hence, it's present).
>> + *
>> + * Returns: Zero for success, otherwise negative number on error.
>> + */
>> +static int qcom_cpufreq_hw_acd_init(struct device *cpu_dev,
>> +				    struct cpufreq_policy *policy,
>> +				    int index)
>> +{
>> +	struct platform_device *pdev = cpufreq_get_driver_data();
>> +	struct qcom_cpufreq_data *ddata = policy->driver_data;
>> +	const struct qcom_cpufreq_soc_data *sdata = ddata->soc_data;
>> +	const struct qcom_cpufreq_soc_acd_data *aregs = &sdata->acd_data;
>> +	const char *acd_resname;
>> +	void __iomem *acd_base;
>> +	u32 rmask;
>> +	int ret;
>> +
>> +	acd_resname = kasprintf(GFP_KERNEL, "osm-acd%d", index);
> 
> How about just sprintf() into a 10 byte array on the stack?
> 

My motto, apart the clearly possible chance to get 1000 clusters in the 
future (lol), is to free the (very little) memory as soon as I'm done 
with it.

Was I too much paranoid there again? :)))


>> +	if (!acd_resname)
>> +		return -ENOMEM;
>> +
>> +	acd_base = devm_platform_ioremap_resource_byname(pdev, acd_resname);
>> +	kfree(acd_resname);
>> +	if (IS_ERR(acd_base)) {
>> +		dev_vdbg(cpu_dev, "Skipping ACD initialization.\n");
>> +		return 0;
>> +	}
>> +
>> +	writel_relaxed(aregs->tl_delay_val, acd_base + aregs->tl_delay_reg);
>> +	writel_relaxed(aregs->acd_ctrl_val, acd_base + aregs->acd_ctrl_reg);
>> +	writel_relaxed(aregs->softstart_val, acd_base + aregs->softstart_reg);
>> +	writel_relaxed(aregs->ext_intf0_val, acd_base + aregs->ext_intf_reg);
>> +	writel_relaxed(aregs->auto_xfer_val,
>> +		       acd_base + aregs->auto_xfer_ctl_reg);
>> +	/*
>> +	 * Before initiating register auto transfer, make sure that all
>> +	 * the writes go through, otherwise bad values will be transferred.
>> +	 */
> 
> Again, please default to using writel() to avoid this. If you really
> need to _wait_ for the value to hit the register do a readl().
> 

The intention here was to really wait for the value to hit the register 
and I recognize that me issuing a write barrier here - even though it 
worked - was stupid.

Will shoot a readl() here to make this programming procedure as safe as 
intended and will remove the barrier.

"And writel() will be" :)  (here and everywhere else)

>> +	wmb();
>> +
>> +	rmask = qcom_cpufreq_acd_regbit(aregs->acd_ctrl_reg) |
>> +		qcom_cpufreq_acd_regbit(aregs->tl_delay_reg) |
>> +		qcom_cpufreq_acd_regbit(aregs->softstart_reg) |
>> +		qcom_cpufreq_acd_regbit(aregs->ext_intf_reg);
>> +	ret = qcom_cpufreq_hw_acd_write_autoxfer(ddata, acd_base, rmask);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Switch CPUSS clock source to ACD clock */
>> +	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
>> +					     aregs->gfmux_cfg_reg, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* (Set, then) Clear DCVS_SW */
>> +	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
>> +					     aregs->dcvs_sw_reg, 1);
>> +	if (ret)
>> +		return ret;
>> +	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
>> +					     aregs->dcvs_sw_reg, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for clock switch time */
>> +	udelay(1);
>> +
>> +	/* Program the final ACD external interface */
>> +	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
>> +					     aregs->ext_intf_reg,
>> +					     aregs->ext_intf1_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Initiate transfer of the final ACD value */
>> +	rmask |= qcom_cpufreq_acd_regbit(aregs->gfmux_cfg_reg);
>> +	writel_relaxed(rmask, acd_base + aregs->auto_xfer_cfg_reg);
>> +
>> +	/* Wait for ACD to stabilize. Same wait as the OSM boot time... */
>> +	udelay(OSM_BOOT_TIME_US);
>> +	return ret;
> 
> ret is 0.
> 

Sorry but, you know, sometimes I get comments the other way around... 
not complaining, don't worry.

Will change to 'return 0;' for all pointed out instances! :)


>> +}
>> +
>> +/**
>> + * qcom_cpufreq_hw_write_lut - Write Lookup Table params to the OSM
>> + * @cpu_dev:   CPU device
>> + * @policy:    CPUFreq policy structure
>> + * @cpu_count: Number of CPUs in the frequency domain
>> + * @index:     Instance number (CPU cluster number)
>> + *
>> + * Program all the Lookup Table (LUT) entries and related thresholds
>> + * to the Operating State Manager on platforms where the same hasn't
>> + * been done already by the bootloader or TrustZone before booting
>> + * the operating system's kernel;
>> + * On these platforms, write access to the OSM is (obviously) not
>> + * blocked by the hypervisor.
>> + *
>> + * Returns: Zero for success, otherwise negative number on error.
>> + */
>> +static int qcom_cpufreq_hw_write_lut(struct device *cpu_dev,
>> +				     struct cpufreq_policy *policy,
>> +				     int cpu_count, int index)
>> +{
>> +	struct platform_device *pdev = cpufreq_get_driver_data();
>> +	struct qcom_cpufreq_data *ddata = policy->driver_data;
>> +	const struct qcom_cpufreq_soc_data *sdata = ddata->soc_data;
>> +	const struct qcom_cpufreq_soc_setup_data *sregs = &sdata->setup_regs;
>> +	struct qcom_cpufreq_hw_params *hw_tbl;
>> +	struct resource *osm_rsrc;
>> +	const char *osm_resname;
>> +	u32 sreg, seq_addr, acc_lval = 0, last_spare = 1;
>> +	int apm_vc = INT_MAX, acc_vc = U8_MAX, acc_idx = 0;
>> +	int acc_val[SEQ_MEM_ACC_MAX_LEVELS];
>> +	int i, ret, num_entries;
>> +
>> +	osm_resname = kasprintf(GFP_KERNEL, "osm-domain%d", index);
> 
> Array on the stack?
> 
>> +	if (!osm_resname)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * On some SoCs the OSM is not getting programmed from bootloader
>> +	 * and needs to be done here: in this case, we need to retrieve
>> +	 * the base physical address for the "Sequencer", so we will get
>> +	 * the OSM base phys and apply the sequencer offset.
>> +	 *
>> +	 * Note: We are not remapping this iospace because we are really
>> +	 *       sending the physical address through SCM calls later.
>> +	 */
>> +	osm_rsrc = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +						osm_resname);
>> +	kfree(osm_resname);
>> +
>> +	if (!osm_rsrc)
>> +		return -ENODEV;
>> +
>> +	seq_addr = osm_rsrc->start + sregs->reg_osm_sequencer;
>> +
>> +	num_entries = qcom_cpufreq_gen_params(cpu_dev, ddata, &hw_tbl,
>> +					      &apm_vc, &acc_vc, cpu_count);
>> +	if (num_entries < 0)
>> +		return num_entries;
>> +
>> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +		struct qcom_cpufreq_hw_params *entry;
>> +		int pos = i * sdata->lut_row_size;
>> +
>> +		/*
>> +		 * If we have reached the end of the params table, write
>> +		 * the last valid entry until the end of the OSM table.
>> +		 */
>> +		if (i < num_entries)
>> +			entry = &hw_tbl[i];
>> +		else
>> +			entry = &hw_tbl[num_entries - 1];
>> +
>> +		writel_relaxed(i, ddata->base + sdata->reg_index + pos);
>> +
>> +		writel_relaxed(entry->volt_lut_val,
>> +			       ddata->base + sdata->reg_volt_lut + pos);
>> +
>> +		writel_relaxed(entry->freq_lut_val,
>> +			       ddata->base + sdata->reg_freq_lut + pos);
>> +
>> +		writel_relaxed(entry->override_val,
>> +			       ddata->base + sregs->reg_override + pos);
>> +
>> +		writel_relaxed(entry->spare_val,
>> +			       ddata->base + sregs->reg_spare + pos);
>> +
>> +		dev_dbg(cpu_dev,
>> +			"Writing [%d] v:0x%x f:0x%x ovr:0x%x s:0x%x\n", i,
>> +			entry->volt_lut_val, entry->freq_lut_val,
>> +			entry->override_val, entry->spare_val);
>> +
>> +		/*
>> +		 * MEM-ACC Virtual Corner threshold voltage: this gets set
>> +		 * as the pairs of corners in which there is a transition
>> +		 * between one MEM-ACC level and the next one.
>> +		 *
>> +		 * Notes: The spare_val can never be zero;
>> +		 *        The first spare_val is always 1;
>> +		 *        The maximum number of pairs is two (four registers).
>> +		 *
>> +		 * Example: (C = Corner Level - M = MEM-ACC Level)
>> +		 *          C0 M1 - C1 M1 - C2 M2 - C3 M2 - C4 M2 - C5 M3
>> +		 *          Pairs: 1-2, 4-5
>> +		 */
>> +		if (entry->spare_val <= last_spare ||
>> +		    acc_idx >= SEQ_MEM_ACC_MAX_LEVELS - 1)
>> +			continue;
>> +
>> +		/* Standard mem-acc pairs using spare_val LUT crossovers */
>> +		last_spare = entry->spare_val;
>> +		acc_val[acc_idx] = i - 1;
>> +		acc_idx++;
>> +		acc_val[acc_idx] = i;
>> +		acc_idx++;
>> +	}
>> +
>> +	/* Sanity check: we *must* have two mem-acc crossovers (four values) */
>> +	if (acc_idx < SEQ_MEM_ACC_MAX_LEVELS - 1)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Customized mem-acc corners, if any; in this case, the last corner
>> +	 * in the external (CPRh) LUT is this one, placed after the APM one.
>> +	 */
>> +	if (acc_vc != U8_MAX) {
>> +		sreg = SEQUENCER_REG(seq_addr, SEQ_MEM_ACC_CROSSOVER_VC);
>> +		ret = qcom_scm_io_writel(sreg, num_entries + 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/*
>> +		 * At the price of very-slightly higher power consumption,
>> +		 * switch the ACC at one corner lower than what we've found,
>> +		 * as this seems to be needed on at least some MSM8998 chips
>> +		 * to achieve full system stability
>> +		 */
>> +		acc_vc--;
>> +
>> +		/* Change only if we have to move the corner down */
>> +		if (acc_vc < acc_val[3]) {
>> +			acc_val[2] = acc_vc - 1;
>> +			acc_val[3] = acc_vc;
>> +		}
>> +
>> +		/* If needed, sanitize previously stored vals from the LUT */
>> +		if (acc_val[2] <= acc_val[1])
>> +			acc_val[1] = acc_val[2] - 1;
>> +		if (acc_val[1] <= acc_val[0])
>> +			acc_val[0] = acc_val[1] - 1;
>> +	}
>> +
>> +	for (i = 0; i < SEQ_MEM_ACC_MAX_LEVELS; i++) {
>> +		ret = qcom_scm_io_writel(SEQ_MEMACC_REG(seq_addr, i),
>> +					 acc_val[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	dev_dbg(cpu_dev, "Wrote MEM-ACC Pairs: [%u-%u] [%u-%u]\n",
>> +		 acc_val[0], acc_val[1], acc_val[2], acc_val[3]);
>> +
>> +	/*
>> +	 * Program the L_VAL of the first corner requesting MEM-ACC
>> +	 * voltage level 3 to the right sequencer register
>> +	 */
>> +	acc_lval = FIELD_GET(LUT_L_VAL, hw_tbl[acc_val[3]].freq_lut_val);
>> +	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_MEM_ACC_LVAL),
>> +				 acc_lval);
>> +	if (ret) {
>> +		dev_dbg(cpu_dev, "Cannot send memacc l_val\n");
>> +		return ret;
>> +	}
>> +	dev_dbg(cpu_dev, "MEM-ACC L-Val is %u\n", acc_lval);
>> +
>> +	/*
>> +	 * Array Power Mux threshold level: the first virtual corner
>> +	 * that requires a switch sequence of the APM from MX to APC.
>> +	 */
>> +	if (apm_vc == INT_MAX)
>> +		apm_vc = LUT_MAX_ENTRIES - 1;
>> +
>> +	/*
>> +	 * APM crossover virtual corner refers to CPRh: there, the APM corner
>> +	 * is always appended to the table (so, at the end of it, right after
>> +	 * the cluster dvfs entries).
>> +	 */
>> +	writel(num_entries, ddata->base + sregs->reg_seq1);
>> +	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_CROSSOVER_VC),
>> +				 num_entries);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_THRESH_VC),
>> +				 apm_vc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_THRESH_PREVC),
>> +				 apm_vc - 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_PARAM),
>> +				 (0x39 | apm_vc << 6));
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(cpu_dev, "Wrote APM Pair: [%u-%u]\n", apm_vc - 1, apm_vc);
>> +	return ret;
> 
> ret is 0.
> 
>> +}
>> +
>> +/**
>> + * qcom_cpufreq_hw_read_lut - Read Lookup Table from the OSM
>> + * @cpu_dev:   CPU device
>> + * @policy:    CPUFreq policy structure
>> + *
>> + * The Operating State Manager Lookup Table can always be read, even
>> + * in case it was pre-programmed by the bootloader or by TrustZone.
>> + * Read the LUT from it in order to build OPPs containing DVFS info.
>> + *
>> + * Returns: Zero for success, otherwise negative number on errors.
>> + */
>>   static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   				    struct cpufreq_policy *policy)
>>   {
>> @@ -166,7 +1066,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>>   		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
>>   				      i * soc_data->lut_row_size);
>> -		src = FIELD_GET(LUT_SRC, data);
>> +		src = data & soc_data->reg_freq_lut_src_mask;
>> +		src >>= ffs(soc_data->reg_freq_lut_src_mask) - 1;
>> +
>>   		lval = FIELD_GET(LUT_L_VAL, data);
>>   		core_count = FIELD_GET(LUT_CORE_COUNT, data);
>>   
>> @@ -175,17 +1077,21 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   		volt = FIELD_GET(LUT_VOLT, data) * 1000;
>>   
>>   		if (src)
>> -			freq = xo_rate * lval / 1000;
>> +			freq = xo_rate * lval;
> 
> Unless I'm missing something this is a cleanup and unrelated to the
> logic you're trying to introduce.
> 

Oh yeah. I'll split in different commits.

>>   		else
>> -			freq = cpu_hw_rate / 1000;
>> +			freq = cpu_hw_rate;
>> +		freq /= 1000;
> 
> Ditto.
> 
>>   
>>   		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
>>   			if (!qcom_cpufreq_update_opp(cpu_dev, freq, volt)) {
>>   				table[i].frequency = freq;
>> -				dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>> -				freq, core_count);
>> +				dev_dbg(cpu_dev,
>> +					"index=%d freq=%d, core_count %d\n",
>> +					i, freq, core_count);
> 
> Fixing the indentation here is nice, but unrelated.
> 
>>   			} else {
>> -				dev_warn(cpu_dev, "failed to update OPP for freq=%d\n", freq);
>> +				dev_warn(cpu_dev,
>> +					 "failed to update OPP for freq=%d\n",
>> +					 freq);
>>   				table[i].frequency = CPUFREQ_ENTRY_INVALID;
>>   			}
>>   
>> @@ -205,18 +1111,19 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   			 * as the boost frequency
>>   			 */
>>   			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
>> -				if (!qcom_cpufreq_update_opp(cpu_dev, prev_freq, volt)) {
>> +				if (!qcom_cpufreq_update_opp(cpu_dev, prev_freq,
>> +							     volt)) {
> 
> The 80 char limit is more of a guideline anyways (and I think it's 100
> now...), so please avoid this.
> 

Sure!

>>   					prev->frequency = prev_freq;
>>   					prev->flags = CPUFREQ_BOOST_FREQ;
>>   				} else {
>> -					dev_warn(cpu_dev, "failed to update OPP for freq=%d\n",
>> +					dev_warn(cpu_dev,
>> +						 "can't update OPP for freq=%u\n",
>>   						 freq);
> 
> Ditto.
> 
>>   				}
>>   			}
>>   
>>   			break;
>>   		}
>> -
> 
> Unrelated/unnecessary change.
> 

Oops, that was unintentional.

>>   		prev_freq = freq;
>>   	}
>>   
>> @@ -227,10 +1134,18 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   	return 0;
>>   }
>>   
>> -static void qcom_get_related_cpus(int index, struct cpumask *m)
>> +/*
>> + * qcom_get_related_cpus - Get mask of CPUs in the same frequency domain
>> + * @index: CPU number
>> + * @m:     Returned CPU mask
>> + *
>> + * Returns: Count of CPUs inserted in the cpumask or negative number for error.
>> + */
>> +static int qcom_get_related_cpus(int index, struct cpumask *m)
>>   {
>>   	struct device_node *cpu_np;
>>   	struct of_phandle_args args;
>> +	int count = 0;
>>   	int cpu, ret;
>>   
>>   	for_each_possible_cpu(cpu) {
>> @@ -245,34 +1160,237 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>>   		if (ret < 0)
>>   			continue;
>>   
>> -		if (index == args.args[0])
>> +		if (index == args.args[0]) {
>>   			cpumask_set_cpu(cpu, m);
>> +			count++;
>> +		}
>>   	}
>> +
>> +	return count > 0 ? count : -EINVAL;
>>   }
>>   
>>   static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>>   	.reg_enable = 0x0,
>>   	.reg_freq_lut = 0x110,
>> +	.reg_freq_lut_src_mask = LUT_SRC_845,
>>   	.reg_volt_lut = 0x114,
>>   	.reg_perf_state = 0x920,
>>   	.lut_row_size = 32,
>> +	.clk_hw_div = 2,
>> +	.uses_tz = true,
>> +};
>> +
>> +static const struct qcom_cpufreq_soc_data msm8998_soc_data = {
>> +	.reg_enable = 0x4,
>> +	.reg_index = 0x150,
>> +	.reg_freq_lut = 0x154,
>> +	.reg_freq_lut_src_mask = LUT_SRC_8998,
>> +	.reg_volt_lut = 0x158,
>> +	.reg_perf_state = 0xf10,
>> +	.lut_row_size = 32,
>> +	.clk_hw_div = 1,
>> +	.uses_tz = false,
>> +	.setup_regs = {
>> +		/* Physical offset for sequencer scm calls */
>> +		.reg_osm_sequencer = 0x300,
>> +
>> +		/* Frequency domain offsets */
>> +		.reg_override = 0x15c,
>> +		.reg_spare = 0x164,
>> +		.reg_cc_zero_behav = 0x0c,
>> +		.reg_spm_cc_hyst = 0x1c,
>> +		.reg_spm_cc_dcvs_dis = 0x20,
>> +		.reg_spm_core_ret_map = 0x24,
>> +		.reg_llm_freq_vote_hyst = 0x2c,
>> +		.reg_llm_volt_vote_hyst = 0x30,
>> +		.reg_llm_intf_dcvs_dis = 0x34,
>> +		.reg_seq1 = 0x48,
>> +		.reg_pdn_fsm_ctrl = 0x70,
>> +		.reg_cc_boost_timer = 0x74,
>> +		.reg_dcvs_boost_timer = 0x84,
>> +		.reg_ps_boost_timer = 0x94,
>> +		.boost_timer_reg_len = 0x4,
>> +		.reg_boost_sync_delay = 0xa0,
>> +		.reg_droop_ctrl = 0xa4,
>> +		.reg_droop_release_ctrl = 0xa8,
>> +		.reg_droop_unstall_ctrl = 0xac,
>> +		.reg_droop_wait_release_ctrl = 0xb0,
>> +		.reg_droop_timer_ctrl = 0xb8,
>> +		.reg_droop_sync_delay = 0xbc,
>> +		.reg_pll_override = 0xc0,
>> +		.reg_cycle_counter = 0xf00,
>> +	},
>> +	.acd_data = {
>> +		.acd_ctrl_reg = 0x4,
>> +		.tl_delay_reg = 0x8,
>> +		.softstart_reg = 0x28,
>> +		.ext_intf_reg = 0x30,
>> +		.dcvs_sw_reg = 0x34,
>> +		.gfmux_cfg_reg = 0x3c,
>> +		.auto_xfer_cfg_reg = 0x80,
>> +		.auto_xfer_reg = 0x84,
>> +		.auto_xfer_ctl_reg = 0x88,
>> +		.auto_xfer_sts_reg = 0x8c,
>> +		.write_ctl_reg = 0x90,
>> +		.write_sts_reg = 0x94,
>> +		.tl_delay_val = 38417,
>> +		.acd_ctrl_val = 0x2b5ffd,
>> +		.softstart_val = 0x501,
>> +		.ext_intf0_val = 0x2cf9ae8,
>> +		.ext_intf1_val = 0x2cf9afe,
>> +		.auto_xfer_val = 0x15,
>> +	},
>>   };
>>   
>>   static const struct qcom_cpufreq_soc_data epss_soc_data = {
>>   	.reg_enable = 0x0,
>>   	.reg_freq_lut = 0x100,
>> +	.reg_freq_lut_src_mask = LUT_SRC_845,
>>   	.reg_volt_lut = 0x200,
>>   	.reg_perf_state = 0x320,
>>   	.lut_row_size = 4,
>> +	.clk_hw_div = 2,
>> +	.uses_tz = true,
>>   };
>>   
>>   static const struct of_device_id qcom_cpufreq_hw_match[] = {
>>   	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
>> +	{ .compatible = "qcom,cpufreq-hw-8998", .data = &msm8998_soc_data },
>>   	{ .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>>   
>> +/**
>> + * qcom_cpufreq_hw_osm_setup - Setup and enable the OSM
>> + * @cpu_dev:   CPU device
>> + * @policy:    CPUFreq policy structure
>> + * @cpu_count: Number of CPUs in the frequency domain
>> + *
>> + * On some platforms, the Operating State Manager (OSM) is not getting
>> + * programmed by the bootloader, nor by TrustZone before booting the OS
>> + * and its register space is not write-protected by the hypervisor.
>> + * In this case, to achieve CPU DVFS, it is needed to program it from
>> + * the OS itself, which includes setting LUT and all the various tunables
>> + * that are required for it to manage the CPU frequencies and voltages
>> + * on its own.
>> + * Calling this function on a platform that had the OSM set-up by TZ
>> + * will result in a hypervisor fault with system reboot in most cases.
>> + *
>> + * Returns: Zero for success, otherwise negative number on errors.
>> + */
>> +static int qcom_cpufreq_hw_osm_setup(struct device *cpu_dev,
>> +				     struct cpufreq_policy *policy,
>> +				     int cpu_count, int index)
>> +{
>> +	struct qcom_cpufreq_data *drv_data = policy->driver_data;
>> +	const struct qcom_cpufreq_soc_setup_data *setup_regs;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = qcom_cpufreq_hw_write_lut(cpu_dev, policy, cpu_count, index);
>> +	if (ret)
>> +		return ret;
>> +
>> +	setup_regs = &drv_data->soc_data->setup_regs;
>> +
>> +	/* Set OSM to XO clock ratio and use XO edge for the cycle counter */
>> +	val = FIELD_PREP(CYCLE_COUNTER_CLK_RATIO, OSM_XO_RATIO_VAL);
>> +	val |= CYCLE_COUNTER_USE_XO_EDGE;
>> +
>> +	/* Enable the CPU cycle counter */
>> +	val |= BIT(0);
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_cycle_counter);
>> +
>> +	/* CoreCount DCVS Policy: Wait time for frequency inc/decrement */
>> +	val = FIELD_PREP(HYSTERESIS_UP_MASK, HYSTERESIS_CC_NS);
>> +	val |= FIELD_PREP(HYSTERESIS_DN_MASK, HYSTERESIS_CC_NS);
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_spm_cc_hyst);
>> +
>> +	/* Set the frequency index 0 and override for cluster power collapse */
>> +	writel_relaxed(BIT(0), drv_data->base + setup_regs->reg_cc_zero_behav);
>> +
>> +	/* Treat cores in retention as active */
>> +	writel_relaxed(0, drv_data->base + setup_regs->reg_spm_core_ret_map);
>> +
>> +	/* Enable CoreCount based DCVS */
>> +	writel_relaxed(0, drv_data->base + setup_regs->reg_spm_cc_dcvs_dis);
>> +
>> +	/* CoreCount DCVS-LLM Policy: Wait time for frequency inc/decrement */
>> +	val = FIELD_PREP(HYSTERESIS_UP_MASK, HYSTERESIS_LLM_NS);
>> +	val |= FIELD_PREP(HYSTERESIS_DN_MASK, HYSTERESIS_LLM_NS);
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_llm_freq_vote_hyst);
>> +
>> +	/* CoreCount DCVS-LLM Policy: Wait time for voltage inc/decrement */
>> +	val = FIELD_PREP(HYSTERESIS_UP_MASK, HYSTERESIS_LLM_NS);
>> +	val |= FIELD_PREP(HYSTERESIS_DN_MASK, HYSTERESIS_LLM_NS);
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_llm_volt_vote_hyst);
>> +
>> +	/* Enable LLM frequency+voltage voting */
>> +	writel_relaxed(0, drv_data->base + setup_regs->reg_llm_intf_dcvs_dis);
>> +
>> +	/* Setup Boost FSM Timers */
>> +	qcom_cpufreq_hw_boost_setup(drv_data->base +
>> +				    setup_regs->reg_cc_boost_timer,
>> +				    setup_regs->boost_timer_reg_len);
>> +	qcom_cpufreq_hw_boost_setup(drv_data->base +
>> +				    setup_regs->reg_dcvs_boost_timer,
>> +				    setup_regs->boost_timer_reg_len);
>> +	qcom_cpufreq_hw_boost_setup(drv_data->base +
>> +				    setup_regs->reg_ps_boost_timer,
>> +				    setup_regs->boost_timer_reg_len);
>> +
>> +	/* PLL signal timing control for Boost */
>> +	writel_relaxed(BOOST_SYNC_DELAY,
>> +		       drv_data->base + setup_regs->reg_boost_sync_delay);
>> +
>> +	/* Setup WFx and PC/RET droop unstall */
>> +	val = FIELD_PREP(DROOP_TIMER1, DROOP_TIMER_NS);
>> +	val |= FIELD_PREP(DROOP_TIMER0, DROOP_TIMER_NS);
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_droop_unstall_ctrl);
>> +
>> +	/* Setup WFx and PC/RET droop wait-to-release */
>> +	val = FIELD_PREP(DROOP_TIMER1, DROOP_WAIT_RELEASE_TIMER_NS);
>> +	val |= FIELD_PREP(DROOP_TIMER0, DROOP_WAIT_RELEASE_TIMER_NS);
>> +	writel_relaxed(val,
>> +		       drv_data->base + setup_regs->reg_droop_wait_release_ctrl);
>> +
>> +	/* PLL signal timing control for Droop */
>> +	writel_relaxed(1, drv_data->base + setup_regs->reg_droop_sync_delay);
>> +
>> +	/* Setup DCVS timers */
>> +	writel_relaxed(DROOP_RELEASE_TIMER_NS,
>> +		       drv_data->base + setup_regs->reg_droop_release_ctrl);
>> +	writel_relaxed(DROOP_TIMER_NS,
>> +		       drv_data->base + setup_regs->reg_droop_timer_ctrl);
>> +
>> +	/* Setup Droop control */
>> +	val = readl_relaxed(drv_data->base + setup_regs->reg_droop_ctrl);
>> +	val |= DROOP_CTRL_VAL;
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_droop_ctrl);
>> +
>> +	/* Enable CC-Boost, DCVS-Boost, PS-Boost, WFx, PC/RET, DCVS FSM */
>> +	val = readl_relaxed(drv_data->base + setup_regs->reg_pdn_fsm_ctrl);
>> +	val |= CC_BOOST_EN | PS_BOOST_EN | DCVS_BOOST_EN;
>> +	val |= WFX_DROOP_EN | PC_RET_EXIT_DROOP_EN | DCVS_DROOP_EN;
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_pdn_fsm_ctrl);
>> +
>> +	/* Enable PLL Droop Override */
>> +	val = PLL_OVERRIDE_DROOP_EN;
>> +	writel_relaxed(val, drv_data->base + setup_regs->reg_pll_override);
>> +
>> +	/* Initialize the Adaptive Clock Distribution */
>> +	ret = qcom_cpufreq_hw_acd_init(cpu_dev, policy, index);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* We're ready: enable the OSM and give it time to boot (5uS) */
>> +	writel_relaxed(1, drv_data->base + drv_data->soc_data->reg_enable);
>> +	udelay(OSM_BOOT_TIME_US);
>> +
>> +	return ret;
> 
> ret is 0.
> 
>> +}
>> +
>>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   {
>>   	struct platform_device *pdev = cpufreq_get_driver_data();
>> @@ -282,7 +1400,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   	struct device *cpu_dev;
>>   	void __iomem *base;
>>   	struct qcom_cpufreq_data *data;
>> -	int ret, index;
>> +	const char *fdom_resname;
>> +	int cpu_count, index, ret;
>>   
>>   	cpu_dev = get_cpu_device(policy->cpu);
>>   	if (!cpu_dev) {
>> @@ -303,9 +1422,14 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	index = args.args[0];
>>   
>> -	base = devm_platform_ioremap_resource(pdev, index);
>> +	fdom_resname = kasprintf(GFP_KERNEL, "freq-domain%d", index);
>> +	if (!fdom_resname)
>> +		return -ENOMEM;
>> +
>> +	base = devm_platform_ioremap_resource_byname(pdev, fdom_resname);
> 
> Now reg-names is a required property. I don't mind this change, but it's
> hidden in the yamlification patch, will comment on this separately.
> 
>>   	if (IS_ERR(base))
>>   		return PTR_ERR(base);
>> +	kfree(fdom_resname);
> 
> If the ioremap failed you're leaking fdom_resname. Perhaps use an array
> on the stack to avoid this?
> 

That's pretty much gone wrong, I agree, let's go for stack...

>>   
>>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>   	if (!data) {
>> @@ -315,22 +1439,31 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	data->soc_data = of_device_get_match_data(&pdev->dev);
>>   	data->base = base;
>> +	policy->driver_data = data;
>>   
>> -	/* HW should be in enabled state to proceed */
>> -	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
>> -		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>> -		ret = -ENODEV;
>> -		goto error;
>> -	}
>> -
>> -	qcom_get_related_cpus(index, policy->cpus);
>> +	cpu_count = qcom_get_related_cpus(index, policy->cpus);
>>   	if (!cpumask_weight(policy->cpus)) {
>>   		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
>>   		ret = -ENOENT;
>>   		goto error;
>>   	}
>>   
>> -	policy->driver_data = data;
>> +	if (!data->soc_data->uses_tz) {
>> +		ret = qcom_cpufreq_hw_osm_setup(cpu_dev, policy,
>> +						cpu_count, index);
>> +		if (ret) {
>> +			dev_err(dev, "Cannot setup the OSM for CPU%d: %d\n",
>> +				policy->cpu, ret);
>> +			goto error;
>> +		}
>> +	}
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
>> +		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>> +		ret = -ENODEV;
>> +		goto error;
>> +	}
>>   
>>   	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
>>   	if (ret) {
>> @@ -355,6 +1488,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	return 0;
>>   error:
>> +	policy->driver_data = NULL;
>>   	devm_iounmap(dev, base);
>>   	return ret;
>>   }
>> @@ -395,9 +1529,51 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>>   
>>   static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>>   {
>> +	const struct qcom_cpufreq_soc_data *soc_data;
>> +	struct device_node *pd_node;
>> +	struct platform_device *pd_dev;
>>   	struct device *cpu_dev;
>>   	struct clk *clk;
>> -	int ret;
>> +	int clk_div, ret;
>> +
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev)
>> +		return -EPROBE_DEFER;
>> +
>> +	soc_data = of_device_get_match_data(&pdev->dev);
>> +	if (!soc_data)
>> +		return -EINVAL;
>> +
>> +	if (!soc_data->uses_tz) {
>> +		/*
>> +		 * When the OSM is not pre-programmed from TZ, we will
>> +		 * need to program the sequencer through SCM calls.
>> +		 */
>> +		if (!qcom_scm_is_available())
>> +			return -EPROBE_DEFER;
>> +
>> +		/*
>> +		 * If there are no power-domains, OSM programming cannot be
>> +		 * performed, as in that case, we wouldn't know where to take
>> +		 * the params from...
>> +		 */
>> +		pd_node = of_parse_phandle(cpu_dev->of_node,
>> +					   "power-domains", 0);
>> +		if (!pd_node) {
>> +			ret = PTR_ERR(pd_node);
>> +			dev_err(cpu_dev, "power domain not found: %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		/*
>> +		 * If the power domain device is not registered yet, then
>> +		 * defer probing this driver until that is available.
>> +		 */
>> +		pd_dev = of_find_device_by_node(pd_node);
>> +		if (!pd_dev || !pd_dev->dev.driver ||
>> +		    !device_is_bound(&pd_dev->dev))
>> +			return -EPROBE_DEFER;
> 
> I wonder if there's a more appropriate way to probe defer on resources
> described in the CPU nodes...
> 

I was wondering the same. I had nightmares about this one.
If there's any better way... please, let me know!


P.S.: There is a v5 of this (and CPR3) set(s) that I had sent 
immediately after this v4, back in January, addressing the big abuse of 
the OPP API that is present in the v4 (this) version of the driver.

- Angelo

> Regards,
> Bjorn
> 
>> +	}
>>   
>>   	clk = clk_get(&pdev->dev, "xo");
>>   	if (IS_ERR(clk))
>> @@ -410,16 +1586,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>>   	if (IS_ERR(clk))
>>   		return PTR_ERR(clk);
>>   
>> -	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
>> +	clk_div = soc_data->clk_hw_div;
>> +	if (clk_div == 0)
>> +		clk_div++;
>> +
>> +	cpu_hw_rate = clk_get_rate(clk) / clk_div;
>>   	clk_put(clk);
>>   
>>   	cpufreq_qcom_hw_driver.driver_data = pdev;
>>   
>>   	/* Check for optional interconnect paths on CPU0 */
>> -	cpu_dev = get_cpu_device(0);
>> -	if (!cpu_dev)
>> -		return -EPROBE_DEFER;
>> -
>>   	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
>>   	if (ret)
>>   		return ret;
>> -- 
>> 2.30.0
>>

