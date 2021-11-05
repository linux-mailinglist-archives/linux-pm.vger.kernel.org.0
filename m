Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFBA4465E6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhKEPl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhKEPl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 11:41:57 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFEC061714
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 08:39:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o4so15109311oia.10
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Riv9a6sDrzsCXhYx9FpnyH7xAkO/+7CrxNLv1Gq2bvI=;
        b=lHAECotdPSMwjZo8n7M46qM5d7VsHCgACJu/KxeGl5XdTsHBQmxMPBL0EfVLP9ThXM
         S0wU9YqBJut2d/gjRYmRFJLCb5lcen/SDEQ0xxJzczV7CdXfQ2hvf/oqu1v/Ti7+OTSY
         7w7m4fVs27FDrcvfHyUR9e4eUqQOhVIDUnnbLMGaTVdIWYSA3dQS4EQHkXMWp38stRO2
         SE7wImD/tgrzIm8rEMR0k6fKPjLPLhTGqYBlU1PYACFZY4Ut+f8w+d8PA6pdBs2mjClY
         8lS00Uzra08rFfibJYcXpPywgLIPo6pISJT4dJ0Twz262jM89wOKQvc+UFL5ziPGP3YM
         IWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Riv9a6sDrzsCXhYx9FpnyH7xAkO/+7CrxNLv1Gq2bvI=;
        b=GcBrQUbx1fHG5bWJc5YVOf2w4IO/WscCq7v/0nuvv8wdvKvKBK9dnCP8s8s4CCVfKf
         ykFT8+ke67XNbRpC29nQdeWGzP53xTtGkXuSOfCzNXOydLEpj9SwHYifQ1Rv2djZ4ox1
         oZTbifjGK6EW7ujP8zCnTX5V+B0vPyI44hoLdzDszs16cnFHQQQr7yb/xB8SViGSxpph
         +EFOihhihuMnjurvBKkqQVr0OUg6N5hMTPu5qEXU6qIN/yrCrMBMz+4El7VKbWvMtjdq
         izuUmVHIp8M84InirAc48VFwRyjw1ZLdKwRuEJRqw8kOWidurFCFH3dNsNJtQG1t7IU7
         BjAw==
X-Gm-Message-State: AOAM5328ByOciBwIYOaG1QISHgwwWbqDUjpy8uZy/LC8gTqn/xCdc8vH
        /TS0nkNZT0g4PKnKNY13+KJKWA==
X-Google-Smtp-Source: ABdhPJywDxeE6d0qPAu5gI0GnIh0U7NcHlymvgPB6B+RJn5aLVZuYfGSIiOhWzrVODhL2pPNgVl8kQ==
X-Received: by 2002:aca:3041:: with SMTP id w62mr19074288oiw.145.1636126756102;
        Fri, 05 Nov 2021 08:39:16 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id e2sm2593427otr.49.2021.11.05.08.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 08:39:15 -0700 (PDT)
Message-ID: <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
Date:   Fri, 5 Nov 2021 10:39:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211103161020.26714-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 11/3/21 11:10 AM, Lukasz Luba wrote:
> Hi all,
>
> This patch set v3 aims to refactor the thermal pressure update
> code. There are already two clients which do similar thing:
> convert the capped frequency value into the capacity of
> affected CPU and call the 'set' function to store the
> reduced capacity into the per-cpu variable.
> There might be more than two of these users. In near future
> it will be scmi-cpufreq driver, which receives notification
> from FW about reduced frequency due to thermal. Other vendors
> might follow. Let's avoid code duplication and potential
> conversion bugs. Move the conversion code into the arch_topology.c
> where the capacity calculation setup code and thermal pressure sit.
>
> Apart from that $subject patches, there is one patch (3/5) which fixes
> issue in qcom-cpufreq-hw.c when the thermal pressure is not
> updated for offline CPUs. It's similar fix that has been merged
> recently for cpufreq_cooling.c:
> 2ad8ccc17d1e4270cf65a3f2
>
> Changes:
> v3:
> - added warning and check if provided capped frequency is lower than
>    max (Viresh)
> - removed check for empty cpu mask (Viresh)
> - replaced tabs with spaces in the doxygen comment (Viresh)
> - renamed {arch|topology}_thermal_pressure_update() to
>    {arch|topology}_update_thermal_pressure() so it's align with scheme (Dietmar)
> - added info about MHz in freq_factor into patch description (Dietmar)
> v2 [2]:
> - added Reviewed-by from Thara for patch 3/5
> - changed the doxygen comment and used mult_frac()
>    according to Thara's suggestion in patch 1/5
> v1 -> [1]
>
> Regards,
> Lukasz Luba
>
> [1] https://lore.kernel.org/linux-pm/20211007080729.8262-1-lukasz.luba@arm.com/
> [2] https://lore.kernel.org/linux-pm/20211015144550.23719-1-lukasz.luba@arm.com/
>
> Lukasz Luba (5):
>    arch_topology: Introduce thermal pressure update function
>    thermal: cpufreq_cooling: Use new thermal pressure update function
>    cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu thermal pressure
>    cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
>    arch_topology: Remove unused topology_set_thermal_pressure() and
>      related
>
>   arch/arm/include/asm/topology.h   |  2 +-
>   arch/arm64/include/asm/topology.h |  2 +-
>   drivers/base/arch_topology.c      | 36 +++++++++++++++++++++++++++----
>   drivers/cpufreq/qcom-cpufreq-hw.c | 14 +++++-------
>   drivers/thermal/cpufreq_cooling.c |  6 +-----
>   include/linux/arch_topology.h     |  4 ++--
>   include/linux/sched/topology.h    |  6 +++---
>   init/Kconfig                      |  2 +-
>   8 files changed, 46 insertions(+), 26 deletions(-)
>
I've been testing this patchset on the Lenovo Yoga C630, and today while 
compiling alacritty and running an apt-get full-upgrade, I found the 
following in dmesg output:

[  194.343903] ------------[ cut here ]------------
[  194.343912] WARNING: CPU: 4 PID: 192 at 
drivers/base/arch_topology.c:188 topology_update_thermal_pressure+0xe4/0x100
[  194.343928] Modules linked in: aes_ce_ccm snd_seq_dummy snd_hrtimer 
snd_seq snd_seq_device algif_hash algif_skcipher af_alg bnep 
cpufreq_ondemand cpufreq_conservative cpufreq_powersave 
cpufreq_userspace lz4 lz4_compress zram zsmalloc q6asm_dai q6routing 
q6afe_dai q6adm q6asm q6afe q6dsp_common snd_soc_wsa881x q6core 
regmap_sdw snd_soc_wcd934x gpio_wcd934x soundwire_qcom snd_soc_wcd_mbhc 
wcd934x regmap_slimbus uvcvideo videobuf2_vmalloc venus_enc venus_dec 
videobuf2_dma_contig videobuf2_memops qrtr_smd fastrpc apr binfmt_misc 
nls_ascii nls_cp437 vfat fat snd_soc_sdm845 snd_soc_rt5663 
snd_soc_qcom_common pm8941_pwrkey joydev snd_soc_rl6231 aes_ce_blk 
qcom_spmi_adc5 soundwire_bus qcom_vadc_common crypto_simd 
qcom_spmi_temp_alarm snd_soc_core cryptd hci_uart snd_compress btqca 
industrialio aes_ce_cipher snd_pcm_dmaengine btrtl crct10dif_ce btbcm 
ghash_ce snd_pcm btintel gf128mul sha2_ce snd_timer venus_core bluetooth 
snd v4l2_mem2mem sha256_arm64 videobuf2_v4l2 videobuf2_common soundcore
[  194.344007]  sha1_ce videodev ecdh_generic ecc mc ath10k_snoc 
ath10k_core hid_multitouch ath mac80211 qcom_rng libarc4 qcom_q6v5_mss 
cfg80211 sg rfkill qcom_q6v5_pas qcom_pil_info slim_qcom_ngd_ctrl 
qcom_wdt pdr_interface qcom_q6v5 evdev rmtfs_mem slimbus qcom_sysmon 
fuse configfs qrtr ip_tables x_tables autofs4 ext4 mbcache jbd2 
panel_simple rtc_pm8xxx msm llcc_qcom ocmem gpu_sched ti_sn65dsi86 
drm_dp_aux_bus drm_kms_helper drm camcc_sdm845 ipa qcom_common 
qmi_helpers mdt_loader gpio_keys pwm_bl
[  194.344056] CPU: 4 PID: 192 Comm: kworker/4:1H Not tainted 5.15.0 #9
[  194.344060] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[  194.344062] Workqueue: events_highpri qcom_lmh_dcvs_poll
[  194.344068] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  194.344070] pc : topology_update_thermal_pressure+0xe4/0x100
[  194.344073] lr : topology_update_thermal_pressure+0x30/0x100
[  194.344075] sp : ffff800014043d10
[  194.344076] x29: ffff800014043d10 x28: 0000000000000000 x27: 
0000000000000000
[  194.344080] x26: ffff759c40b66974 x25: ffff759db37a2405 x24: 
ffff759c40e83358
[  194.344084] x23: 0000000000000000 x22: ffffb2699eafe1d8 x21: 
00000000002d1e00
[  194.344087] x20: ffff759c49f5bc20 x19: 000000000000b8cc x18: 
0000000000000000
[  194.344090] x17: 2f756e672d78756e x16: ffffb2699d7d83d0 x15: 
0000000000000000
[  194.344093] x14: 0000000000000000 x13: 0000000000000030 x12: 
0101010101010101
[  194.344096] x11: 7f7f7f7f7f7f7f7f x10: feff68716f676668 x9 : 
ffffb2699dd66a58
[  194.344099] x8 : fefefefefefefeff x7 : 000000000000000f x6 : 
0000000000000002
[  194.344102] x5 : ffffc33415124000 x4 : 0000000000000400 x3 : 
0000000000000b19
[  194.344105] x2 : 0000000000000b8c x1 : ffffb2699e678f40 x0 : 
ffffb2699e678f48
[  194.344108] Call trace:
[  194.344110]  topology_update_thermal_pressure+0xe4/0x100
[  194.344113]  qcom_lmh_dcvs_notify+0xc8/0x160
[  194.344115]  qcom_lmh_dcvs_poll+0x20/0x2c
[  194.344116]  process_one_work+0x1f4/0x490
[  194.344120]  worker_thread+0x188/0x504
[  194.344121]  kthread+0x12c/0x140
[  194.344125]  ret_from_fork+0x10/0x20
[  194.344128] ---[ end trace bd0039c4fb892d5b ]---
[  194.344170] ------------[ cut here ]------------
[  194.344171] WARNING: CPU: 4 PID: 161 at 
drivers/base/arch_topology.c:188 topology_update_thermal_pressure+0xe4/0x100
[  194.344175] Modules linked in: aes_ce_ccm snd_seq_dummy snd_hrtimer 
snd_seq snd_seq_device algif_hash algif_skcipher af_alg bnep 
cpufreq_ondemand cpufreq_conservative cpufreq_powersave 
cpufreq_userspace lz4 lz4_compress zram zsmalloc q6asm_dai q6routing 
q6afe_dai q6adm q6asm q6afe q6dsp_common snd_soc_wsa881x q6core 
regmap_sdw snd_soc_wcd934x gpio_wcd934x soundwire_qcom snd_soc_wcd_mbhc 
wcd934x regmap_slimbus uvcvideo videobuf2_vmalloc venus_enc venus_dec 
videobuf2_dma_contig videobuf2_memops qrtr_smd fastrpc apr binfmt_misc 
nls_ascii nls_cp437 vfat fat snd_soc_sdm845 snd_soc_rt5663 
snd_soc_qcom_common pm8941_pwrkey joydev snd_soc_rl6231 aes_ce_blk 
qcom_spmi_adc5 soundwire_bus qcom_vadc_common crypto_simd 
qcom_spmi_temp_alarm snd_soc_core cryptd hci_uart snd_compress btqca 
industrialio aes_ce_cipher snd_pcm_dmaengine btrtl crct10dif_ce btbcm 
ghash_ce snd_pcm btintel gf128mul sha2_ce snd_timer venus_core bluetooth 
snd v4l2_mem2mem sha256_arm64 videobuf2_v4l2 videobuf2_common soundcore
[  194.344225]  sha1_ce videodev ecdh_generic ecc mc ath10k_snoc 
ath10k_core hid_multitouch ath mac80211 qcom_rng libarc4 qcom_q6v5_mss 
cfg80211 sg rfkill qcom_q6v5_pas qcom_pil_info slim_qcom_ngd_ctrl 
qcom_wdt pdr_interface qcom_q6v5 evdev rmtfs_mem slimbus qcom_sysmon 
fuse configfs qrtr ip_tables x_tables autofs4 ext4 mbcache jbd2 
panel_simple rtc_pm8xxx msm llcc_qcom ocmem gpu_sched ti_sn65dsi86 
drm_dp_aux_bus drm_kms_helper drm camcc_sdm845 ipa qcom_common 
qmi_helpers mdt_loader gpio_keys pwm_bl
[  194.344256] CPU: 4 PID: 161 Comm: irq/159-dcvsh-i Tainted: G        
W         5.15.0 #9
[  194.344259] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[  194.344260] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  194.344262] pc : topology_update_thermal_pressure+0xe4/0x100
[  194.344264] lr : topology_update_thermal_pressure+0x30/0x100
[  194.344266] sp : ffff800011e93cf0
[  194.344267] x29: ffff800011e93cf0 x28: 0000000000000000 x27: 
0000000000000000
[  194.344270] x26: ffffb2699d4d0a80 x25: ffffb2699d4d0b60 x24: 
ffff759c40caec00
[  194.344273] x23: ffff759c49f02c40 x22: ffffb2699eafe1d8 x21: 
00000000002d1e00
[  194.344276] x20: ffff759c49f5bc20 x19: 000000000000b8cc x18: 
000000000000000e
[  194.344280] x17: 0000000000000001 x16: 0000000000000019 x15: 
0000000000000033
[  194.344283] x14: 000000000000004c x13: 0000000000000068 x12: 
0000000000000040
[  194.344286] x11: ffff759c4049f478 x10: ffff759c4049f47a x9 : 
ffffb2699dd66a58
[  194.344288] x8 : ffff759c40401dd0 x7 : 0000000000000000 x6 : 
0000000000000002
[  194.344291] x5 : ffffc33415124000 x4 : 0000000000000400 x3 : 
0000000000000b19
[  194.344294] x2 : 0000000000000b8c x1 : ffffb2699e678f40 x0 : 
ffffb2699e678f48
[  194.344297] Call trace:
[  194.344298]  topology_update_thermal_pressure+0xe4/0x100
[  194.344300]  qcom_lmh_dcvs_notify+0xc8/0x160
[  194.344302]  qcom_lmh_dcvs_handle_irq+0x30/0x44
[  194.344304]  irq_thread_fn+0x38/0xb0
[  194.344307]  irq_thread+0x194/0x3b0
[  194.344308]  kthread+0x12c/0x140
[  194.344311]  ret_from_fork+0x10/0x20
[  194.344313] ---[ end trace bd0039c4fb892d5c ]---
[  194.405913] ------------[ cut here ]------------
[  194.405923] WARNING: CPU: 4 PID: 192 at 
drivers/base/arch_topology.c:188 topology_update_thermal_pressure+0xe4/0x100
[  194.405939] Modules linked in: aes_ce_ccm snd_seq_dummy snd_hrtimer 
snd_seq snd_seq_device algif_hash algif_skcipher af_alg bnep 
cpufreq_ondemand cpufreq_conservative cpufreq_powersave 
cpufreq_userspace lz4 lz4_compress zram zsmalloc q6asm_dai q6routing 
q6afe_dai q6adm q6asm q6afe q6dsp_common snd_soc_wsa881x q6core 
regmap_sdw snd_soc_wcd934x gpio_wcd934x soundwire_qcom snd_soc_wcd_mbhc 
wcd934x regmap_slimbus uvcvideo videobuf2_vmalloc venus_enc venus_dec 
videobuf2_dma_contig videobuf2_memops qrtr_smd fastrpc apr binfmt_misc 
nls_ascii nls_cp437 vfat fat snd_soc_sdm845 snd_soc_rt5663 
snd_soc_qcom_common pm8941_pwrkey joydev snd_soc_rl6231 aes_ce_blk 
qcom_spmi_adc5 soundwire_bus qcom_vadc_common crypto_simd 
qcom_spmi_temp_alarm snd_soc_core cryptd hci_uart snd_compress btqca 
industrialio aes_ce_cipher snd_pcm_dmaengine btrtl crct10dif_ce btbcm 
ghash_ce snd_pcm btintel gf128mul sha2_ce snd_timer venus_core bluetooth 
snd v4l2_mem2mem sha256_arm64 videobuf2_v4l2 videobuf2_common soundcore
[  194.406038]  sha1_ce videodev ecdh_generic ecc mc ath10k_snoc 
ath10k_core hid_multitouch ath mac80211 qcom_rng libarc4 qcom_q6v5_mss 
cfg80211 sg rfkill qcom_q6v5_pas qcom_pil_info slim_qcom_ngd_ctrl 
qcom_wdt pdr_interface qcom_q6v5 evdev rmtfs_mem slimbus qcom_sysmon 
fuse configfs qrtr ip_tables x_tables autofs4 ext4 mbcache jbd2 
panel_simple rtc_pm8xxx msm llcc_qcom ocmem gpu_sched ti_sn65dsi86 
drm_dp_aux_bus drm_kms_helper drm camcc_sdm845 ipa qcom_common 
qmi_helpers mdt_loader gpio_keys pwm_bl
[  194.406089] CPU: 4 PID: 192 Comm: kworker/4:1H Tainted: G        
W         5.15.0 #9
[  194.406092] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[  194.406094] Workqueue: events_highpri qcom_lmh_dcvs_poll
[  194.406101] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  194.406104] pc : topology_update_thermal_pressure+0xe4/0x100
[  194.406107] lr : topology_update_thermal_pressure+0x30/0x100
[  194.406109] sp : ffff800014043d10
[  194.406111] x29: ffff800014043d10 x28: 0000000000000000 x27: 
0000000000000000
[  194.406114] x26: ffff759c40b66974 x25: ffff759db37a2405 x24: 
ffff759c40e83358
[  194.406117] x23: 0000000000000000 x22: ffffb2699eafe1d8 x21: 
00000000002d1e00
[  194.406120] x20: ffff759c49f5bc20 x19: 000000000000b8cc x18: 
0000000000000000
[  194.406123] x17: ffffc33415124000 x16: ffff800010024000 x15: 
0000000000004000
[  194.406126] x14: 0000000000000000 x13: 0000000000000030 x12: 
0101010101010101
[  194.406129] x11: 7f7f7f7f7f7f7f7f x10: feff68716f676668 x9 : 
ffffb2699dd66a58
[  194.406132] x8 : fefefefefefefeff x7 : 000000000000000f x6 : 
0000000000000002
[  194.406135] x5 : ffffc33415124000 x4 : 0000000000000400 x3 : 
0000000000000b19
[  194.406138] x2 : 0000000000000b8c x1 : ffffb2699e678f40 x0 : 
ffffb2699e678f48
[  194.406141] Call trace:
[  194.406143]  topology_update_thermal_pressure+0xe4/0x100
[  194.406146]  qcom_lmh_dcvs_notify+0xc8/0x160
[  194.406148]  qcom_lmh_dcvs_poll+0x20/0x2c
[  194.406149]  process_one_work+0x1f4/0x490
[  194.406153]  worker_thread+0x188/0x504
[  194.406154]  kthread+0x12c/0x140
[  194.406158]  ret_from_fork+0x10/0x20
[  194.406162] ---[ end trace bd0039c4fb892d5d ]---

