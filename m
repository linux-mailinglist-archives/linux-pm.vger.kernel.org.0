Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D54466F9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhKEQ3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 12:29:19 -0400
Received: from foss.arm.com ([217.140.110.172]:33326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232708AbhKEQ3T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 12:29:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3772E2F;
        Fri,  5 Nov 2021 09:26:39 -0700 (PDT)
Received: from [10.57.26.129] (unknown [10.57.26.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411113F7F5;
        Fri,  5 Nov 2021 09:26:35 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
To:     Steev Klimaszewski <steev@kali.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
Date:   Fri, 5 Nov 2021 16:26:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Steev,

On 11/5/21 3:39 PM, Steev Klimaszewski wrote:
> Hi Lukasz,
> 

[snip]

> I've been testing this patchset on the Lenovo Yoga C630, and today while 
> compiling alacritty and running an apt-get full-upgrade, I found the 
> following in dmesg output:

Thank you for testing and sending feedback!

Are you using a mainline kernel or you applied on some vendor production
kernel this patch set? I need to exclude a different code base
from the equation, especially to the arch_topology.c init code.

> 
> [  194.343903] ------------[ cut here ]------------
> [  194.343912] WARNING: CPU: 4 PID: 192 at 
> drivers/base/arch_topology.c:188 
> topology_update_thermal_pressure+0xe4/0x100
> [  194.343928] Modules linked in: aes_ce_ccm snd_seq_dummy snd_hrtimer 
> snd_seq snd_seq_device algif_hash algif_skcipher af_alg bnep 
> cpufreq_ondemand cpufreq_conservative cpufreq_powersave 
> cpufreq_userspace lz4 lz4_compress zram zsmalloc q6asm_dai q6routing 
> q6afe_dai q6adm q6asm q6afe q6dsp_common snd_soc_wsa881x q6core 
> regmap_sdw snd_soc_wcd934x gpio_wcd934x soundwire_qcom snd_soc_wcd_mbhc 
> wcd934x regmap_slimbus uvcvideo videobuf2_vmalloc venus_enc venus_dec 
> videobuf2_dma_contig videobuf2_memops qrtr_smd fastrpc apr binfmt_misc 
> nls_ascii nls_cp437 vfat fat snd_soc_sdm845 snd_soc_rt5663 
> snd_soc_qcom_common pm8941_pwrkey joydev snd_soc_rl6231 aes_ce_blk 
> qcom_spmi_adc5 soundwire_bus qcom_vadc_common crypto_simd 
> qcom_spmi_temp_alarm snd_soc_core cryptd hci_uart snd_compress btqca 
> industrialio aes_ce_cipher snd_pcm_dmaengine btrtl crct10dif_ce btbcm 
> ghash_ce snd_pcm btintel gf128mul sha2_ce snd_timer venus_core bluetooth 
> snd v4l2_mem2mem sha256_arm64 videobuf2_v4l2 videobuf2_common soundcore
> [  194.344007]  sha1_ce videodev ecdh_generic ecc mc ath10k_snoc 
> ath10k_core hid_multitouch ath mac80211 qcom_rng libarc4 qcom_q6v5_mss 
> cfg80211 sg rfkill qcom_q6v5_pas qcom_pil_info slim_qcom_ngd_ctrl 
> qcom_wdt pdr_interface qcom_q6v5 evdev rmtfs_mem slimbus qcom_sysmon 
> fuse configfs qrtr ip_tables x_tables autofs4 ext4 mbcache jbd2 
> panel_simple rtc_pm8xxx msm llcc_qcom ocmem gpu_sched ti_sn65dsi86 
> drm_dp_aux_bus drm_kms_helper drm camcc_sdm845 ipa qcom_common 
> qmi_helpers mdt_loader gpio_keys pwm_bl
> [  194.344056] CPU: 4 PID: 192 Comm: kworker/4:1H Not tainted 5.15.0 #9
> [  194.344060] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
> 9UCN33WW(V2.06) 06/ 4/2019
> [  194.344062] Workqueue: events_highpri qcom_lmh_dcvs_poll
> [  194.344068] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [  194.344070] pc : topology_update_thermal_pressure+0xe4/0x100
> [  194.344073] lr : topology_update_thermal_pressure+0x30/0x100
> [  194.344075] sp : ffff800014043d10
> [  194.344076] x29: ffff800014043d10 x28: 0000000000000000 x27: 
> 0000000000000000
> [  194.344080] x26: ffff759c40b66974 x25: ffff759db37a2405 x24: 
> ffff759c40e83358
> [  194.344084] x23: 0000000000000000 x22: ffffb2699eafe1d8 x21: 
> 00000000002d1e00
> [  194.344087] x20: ffff759c49f5bc20 x19: 000000000000b8cc x18: 
> 0000000000000000
> [  194.344090] x17: 2f756e672d78756e x16: ffffb2699d7d83d0 x15: 
> 0000000000000000
> [  194.344093] x14: 0000000000000000 x13: 0000000000000030 x12: 
> 0101010101010101
> [  194.344096] x11: 7f7f7f7f7f7f7f7f x10: feff68716f676668 x9 : 
> ffffb2699dd66a58
> [  194.344099] x8 : fefefefefefefeff x7 : 000000000000000f x6 : 
> 0000000000000002
> [  194.344102] x5 : ffffc33415124000 x4 : 0000000000000400 x3 : 
> 0000000000000b19
> [  194.344105] x2 : 0000000000000b8c x1 : ffffb2699e678f40 x0 : 
> ffffb2699e678f48
> [  194.344108] Call trace:
> [  194.344110]  topology_update_thermal_pressure+0xe4/0x100
> [  194.344113]  qcom_lmh_dcvs_notify+0xc8/0x160
> [  194.344115]  qcom_lmh_dcvs_poll+0x20/0x2c
> [  194.344116]  process_one_work+0x1f4/0x490
> [  194.344120]  worker_thread+0x188/0x504
> [  194.344121]  kthread+0x12c/0x140
> [  194.344125]  ret_from_fork+0x10/0x20
> [  194.344128] ---[ end trace bd0039c4fb892d5b ]---

[snip]

That's interesting why we hit this. I should have added info about
those two values, which are compared.

Could you make this change and try it again, please?
We would know the problematic values, which triggered this.
---------------------8<-----------------------------------
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index db18d79065fe..0d8db0927041 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -185,8 +185,11 @@ void topology_update_thermal_pressure(const struct 
cpumask *cpus,
         /* Convert to MHz scale which is used in 'freq_factor' */
         capped_freq /= 1000;

-       if (WARN_ON(max_freq < capped_freq))
+       if (max_freq < capped_freq) {
+               pr_warn("THERMAL_PRESSURE: max_freq (%lu) < capped_freq 
(%lu) for CPUs [%*pbl]\n",
+                       max_freq, capped_freq, cpumask_pr_args(cpus));
                 return;
+       }

         capacity = mult_frac(capped_freq, max_capacity, max_freq);

------------------------------>8---------------------------

Could you also dump for me the cpufreq and capacity sysfs content?
$ grep . /sys/devices/system/cpu/cpu*/cpufreq/*
$ grep . /sys/devices/system/cpu/cpu*/cpu_capacity

Regards,
Lukasz
