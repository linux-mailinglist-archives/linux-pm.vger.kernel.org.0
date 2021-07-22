Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35E3D1C49
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 05:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhGVCd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGVCdy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 22:33:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410BC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 20:14:30 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so5186125oiv.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 20:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SVe4xUwviYCln6UFypUh195dRZrh9mig/tZa7Mov25Y=;
        b=Q1kqTQ35FYsHWVdwEHZyo4CQkFwuDQgYd8OPCiagMkCOBgZm+XMSjRxV9LEA6ZbjDA
         sYHs4O3yvJrLsAPWArnNSyrflX1jDtEQgaFKPmk+pjO/cw/YVP1PNY6rJSbZLga0TAQ7
         Xmg/mB4wcKM5NRs6UIikiFiRVfZ6YdxwtMRh/n02/lAedW5poxyz6bNE6B1AeckFcZkz
         dt4u75l57Z2k/VtPrnTG5ltEsTXA6eGJZHzSpXRv+oCh0w879nAjXOuAcgCnuJ91UqTU
         Cj07J+c+vME8O/SJ69P6b7RvwP5NlZXsZoc47aUm0AdYSvbBK02jhgBW7cXPcPVWHf8F
         u7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SVe4xUwviYCln6UFypUh195dRZrh9mig/tZa7Mov25Y=;
        b=AdKIWnKC4sZlDcbJhYQcx9QXyoU1JJNu6Xhc/Bvq9iYTbLYRz3YnlBevLMkNw6L1a6
         WuDx1QgxsRAhTORUzTSvs65C5rqRyg095URVagfH7Ko6dUSTo8mqIO3JSIe62DZ2rv1R
         bFzy53AuSqVfdFGbdMcVQjMsRs3xgy9F9gdbAVxz47GQ//EbYYdR/qiR9nHuMd4CMsY/
         HOZlcsU3X8Vob1ZwfAANW7mdxGEl0T/iGixeBwWPJV6qFYSDHGkBcC1CPgxTokbtccuS
         z7/4MFIbc5cWFvmZi6eN4KolF9rku6yDfJ6kqKkvrmJxibU34sDVl39oi8GY83Y8PKiQ
         CSNA==
X-Gm-Message-State: AOAM531lQ6jpF3sTbaf/8ic43XwPCo+z/u3lnoEiH764IieoFpFMfIDo
        YPjSosA9lKwXm4J6GbuzX/96mg==
X-Google-Smtp-Source: ABdhPJyemqZzuzY7TnRUy3x6Do6ZA9+AQMjUmLqDYw2fxzufTEQ0F9eTtzBU5rGi0rYzM3VWYoyRMw==
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr4355606oib.15.1626923669217;
        Wed, 21 Jul 2021 20:14:29 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id v11sm2490478ott.68.2021.07.21.20.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 20:14:28 -0700 (PDT)
Subject: Re: [Patch v3 0/6] Introduce LMh driver for Qualcomm SoCs
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <c630a7a0-d1d0-d04c-8abf-2490c0932661@kali.org>
Date:   Wed, 21 Jul 2021 22:14:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708120656.663851-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thara!

On 7/8/21 7:06 AM, Thara Gopinath wrote:
> Limits Management Hardware(LMh) is a hardware infrastructure on some
> Qualcomm SoCs that can enforce temperature and current limits as programmed
> by software for certain IPs like CPU. On many newer SoCs LMh is configured
> by firmware/TZ and no programming is needed from the kernel side. But on
> certain SoCs like sdm845 the firmware does not do a complete programming of
> the h/w block. On such SoCs kernel software has to explicitly set up the
> temperature limits and turn on various monitoring and enforcing algorithms
> on the hardware.
>
> Introduce support for enabling and programming various limit settings and
> monitoring capabilities of Limits Management Hardware(LMh) associated with
> cpu clusters. Also introduce support in cpufreq hardware driver to monitor
> the interrupt associated with cpu frequency throttling so that this
> information can be conveyed to the schdeuler via thermal pressure
> interface.
>
> With this patch series following cpu performance improvement(30-70%) is
> observed on sdm845. The reasoning here is that without LMh being programmed
> properly from the kernel, the default settings were enabling thermal
> mitigation for CPUs at too low a temperature (around 70-75 degree C).  This
> in turn meant that many a time CPUs were never actually allowed to hit the
> maximum possible/required frequencies.
>
> UnixBench whets and dhry (./Run whets dhry)
> System Benchmarks Index Score
>
>                 Without LMh Support             With LMh Support
> 1 copy test     1353.7                          1773.2
>
> 8 copy tests    4473.6                          7402.3
>
> Sysbench cpu
> sysbench cpu --threads=8 --time=60 --cpu-max-prime=100000 run
>
>                 Without LMh Support             With LMh Support
> Events per
> second                  355                             614
>
> Avg Latency(ms)         21.84                           13.02
>
> v2->v3:
> 	- Included patch adding dt binding documentation for LMh nodes.
> 	- Rebased to v5.13
>
> Thara Gopinath (6):
>   firmware: qcom_scm: Introduce SCM calls to access LMh
>   thermal: qcom: Add support for LMh driver
>   cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
>   arm64: boot: dts: qcom: sdm45: Add support for LMh node
>   arm64: boot: dts: qcom: sdm845: Remove cpufreq cooling devices for CPU
>     thermal zones
>   dt-bindings: thermal: Add dt binding for QCOM LMh
>
>  .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 162 ++----------
>  drivers/cpufreq/qcom-cpufreq-hw.c             | 118 +++++++++
>  drivers/firmware/qcom_scm.c                   |  58 +++++
>  drivers/firmware/qcom_scm.h                   |   4 +
>  drivers/thermal/qcom/Kconfig                  |  10 +
>  drivers/thermal/qcom/Makefile                 |   1 +
>  drivers/thermal/qcom/lmh.c                    | 239 ++++++++++++++++++
>  include/linux/qcom_scm.h                      |  14 +
>  9 files changed, 570 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
>  create mode 100644 drivers/thermal/qcom/lmh.c
>
I've been using these patches on a 5.13 kernel
(https://github.com/steev/linux/tree/linux-5.13.y - while trying to
track down a different issue, while playing a video on youtube, as well
as compressing a 9.2GB file with xz, I got the following

|Jul 21 21:44:21 limitless kernel: [ 5438.914591] EXT4-fs (loop0p1):
mounting ext3 file system using the ext4 subsystem |

|Jul 21 21:44:21 limitless kernel: [ 5438.920817] EXT4-fs (loop0p1):
mounted filesystem with ordered data mode. Opts: (null). Quota mode:
none. |

|Jul 21 21:45:56 limitless kernel: [ 5533.893290] BUG: scheduling while
atomic: swapper/0/0/0x00010000 |

|Jul 21 21:45:56 limitless kernel: [ 5533.893333] Modules linked in:
dm_mod loop tcp_diag inet_diag aes_ce_ccm rfcomm algif_hash
algif_skcipher af_alg bnep lz4 lz4_compress q6asm_dai zram q6routing
zsmalloc q6afe_dai q6adm q6asm q6afe q6dsp_common q6core snd_soc_wsa881x
regmap_sdw snd_soc_wcd934x soundwire_qcom gpio_wcd934x binfmt_misc
venus_enc venus_dec videobuf2_dma_contig nls_ascii nls_cp437 vfat fat
wcd934x regmap_slimbus qrtr_smd fastrpc apr aes_ce_blk crypto_simd
cryptd aes_ce_cipher crct10dif_ce ghash_ce gf128mul sha2_ce uvcvideo
videobuf2_vmalloc videobuf2_memops hci_uart ath10k_snoc sha256_arm64
sha1_ce btqca ath10k_core ath btrtl mac80211 btbcm btintel
snd_soc_sdm845 snd_soc_rt5663 snd_soc_qcom_common snd_soc_rl6231
soundwire_bus pm8941_pwrkey qcom_spmi_adc5 bluetooth qcom_vadc_common
snd_soc_core venus_core snd_compress snd_pcm_dmaengine snd_pcm
v4l2_mem2mem snd_timer snd qcom_spmi_temp_alarm videobuf2_v4l2 soundcore
industrialio videobuf2_common videodev joydev mc hid_multitouch
ecdh_generic ecc cfg80211 |

|Jul 21 21:45:56 limitless kernel: [ 5533.893841]  qcom_rng sg rfkill
qrtr ns libarc4 qcom_q6v5_mss slim_qcom_ngd_ctrl qcom_q6v5_pas evdev
pdr_interface qcom_pil_info qcom_q6v5 slimbus qcom_sysmon rmtfs_mem
bam_dma qcom_wdt fuse configfs ip_tables x_tables autofs4 ext4 mbcache
jbd2 msm rtc_pm8xxx llcc_qcom ti_sn65dsi86 ocmem i2c_hid_of
drm_kms_helper ipa qcom_common qmi_helpers mdt_loader camcc_sdm845
panel_simple drm gpio_keys |

|Jul 21 21:45:56 limitless kernel: [ 5533.894072] CPU: 0 PID: 0 Comm:
swapper/0 Tainted: G        W         5.13.4 #1 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894087] Hardware name: LENOVO
81JL/LNVNB161216, BIOS 9UCN33WW(V2.06) 06/ 4/2019 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894098] Call trace: |

|Jul 21 21:45:56 limitless kernel: [
5533.894103]  dump_backtrace+0x0/0x1e4 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894133]  show_stack+0x24/0x30 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894150]  dump_stack+0xd0/0x12c |

|Jul 21 21:45:56 limitless kernel: [
5533.894168]  __schedule_bug+0x68/0x80 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894186]  __schedule+0x74c/0x8ac |

|Jul 21 21:45:56 limitless kernel: [ 5533.894202]  schedule+0x54/0xe0 |

|Jul 21 21:45:56 limitless kernel: [
5533.894217]  schedule_preempt_disabled+0x1c/0x2c |

|Jul 21 21:45:56 limitless kernel: [
5533.894234]  __mutex_lock.constprop.0+0x55c/0x590 |

|Jul 21 21:45:56 limitless kernel: [
5533.894247]  __mutex_lock_slowpath+0x1c/0x30 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894260]  mutex_lock+0x6c/0x80 |

|Jul 21 21:45:56 limitless kernel: [
5533.894271]  dev_pm_opp_find_freq_floor+0x4c/0x200 |

|Jul 21 21:45:56 limitless kernel: [
5533.894287]  qcom_lmh_dcvs_notify+0x74/0x170 |

|Jul 21 21:45:56 limitless kernel: [
5533.894301]  qcom_lmh_dcvs_handle_irq+0x30/0x44 |

|Jul 21 21:45:56 limitless kernel: [
5533.894313]  __handle_irq_event_percpu+0x68/0x210 |

|Jul 21 21:45:56 limitless kernel: [
5533.894328]  handle_irq_event+0x6c/0x1b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.894340]  handle_simple_irq+0xc8/0x170 |

|Jul 21 21:45:56 limitless kernel: [
5533.894355]  generic_handle_irq+0x3c/0x5c |

|Jul 21 21:45:56 limitless kernel: [
5533.894368]  lmh_handle_irq+0x40/0x50 |

|Jul 21 21:45:56 limitless kernel: [
5533.894383]  __handle_irq_event_percpu+0x68/0x210 |

|Jul 21 21:45:56 limitless kernel: [
5533.894395]  handle_irq_event+0x6c/0x1b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.894407]  handle_fasteoi_irq+0xcc/0x1fc |

|Jul 21 21:45:56 limitless kernel: [
5533.894421]  __handle_domain_irq+0x88/0xec |

|Jul 21 21:45:56 limitless kernel: [
5533.894433]  gic_handle_irq+0xc8/0x148 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894446]  el1_irq+0xbc/0x140 |

|Jul 21 21:45:56 limitless kernel: [
5533.894458]  arch_local_irq_enable+0xc/0x14 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894473]  __schedule+0x2fc/0x8ac |

|Jul 21 21:45:56 limitless kernel: [
5533.894489]  schedule_idle+0x34/0x54 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894504]  do_idle+0x1a4/0x2b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.894520]  cpu_startup_entry+0x34/0xa0 |

|Jul 21 21:45:56 limitless kernel: [ 5533.894536]  rest_init+0xcc/0xdc |

|Jul 21 21:45:56 limitless kernel: [
5533.894550]  arch_call_rest_init+0x1c/0x28 |

|Jul 21 21:45:56 limitless kernel: [
5533.894567]  start_kernel+0x5b4/0x5ec |

|Jul 21 21:45:56 limitless kernel: [ 5533.894954] ------------[ cut here
]------------ |

|Jul 21 21:45:56 limitless kernel: [ 5533.894966] irq 156 handler
qcom_lmh_dcvs_handle_irq+0x0/0x44 enabled interrupts |

|Jul 21 21:45:56 limitless kernel: [ 5533.895005] WARNING: CPU: 0 PID: 0
at kernel/irq/handle.c:159 __handle_irq_event_percpu+0x1d8/0x210 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895028] Modules linked in:
dm_mod loop tcp_diag inet_diag aes_ce_ccm rfcomm algif_hash
algif_skcipher af_alg bnep lz4 lz4_compress q6asm_dai zram q6routing
zsmalloc q6afe_dai q6adm q6asm q6afe q6dsp_common q6core snd_soc_wsa881x
regmap_sdw snd_soc_wcd934x soundwire_qcom gpio_wcd934x binfmt_misc
venus_enc venus_dec videobuf2_dma_contig nls_ascii nls_cp437 vfat fat
wcd934x regmap_slimbus qrtr_smd fastrpc apr aes_ce_blk crypto_simd
cryptd aes_ce_cipher crct10dif_ce ghash_ce gf128mul sha2_ce uvcvideo
videobuf2_vmalloc videobuf2_memops hci_uart ath10k_snoc sha256_arm64
sha1_ce btqca ath10k_core ath btrtl mac80211 btbcm btintel
snd_soc_sdm845 snd_soc_rt5663 snd_soc_qcom_common snd_soc_rl6231
soundwire_bus pm8941_pwrkey qcom_spmi_adc5 bluetooth qcom_vadc_common
snd_soc_core venus_core snd_compress snd_pcm_dmaengine snd_pcm
v4l2_mem2mem snd_timer snd qcom_spmi_temp_alarm videobuf2_v4l2 soundcore
industrialio videobuf2_common videodev joydev mc hid_multitouch
ecdh_generic ecc cfg80211 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895508]  qcom_rng sg rfkill
qrtr ns libarc4 qcom_q6v5_mss slim_qcom_ngd_ctrl qcom_q6v5_pas evdev
pdr_interface qcom_pil_info qcom_q6v5 slimbus qcom_sysmon rmtfs_mem
bam_dma qcom_wdt fuse configfs ip_tables x_tables autofs4 ext4 mbcache
jbd2 msm rtc_pm8xxx llcc_qcom ti_sn65dsi86 ocmem i2c_hid_of
drm_kms_helper ipa qcom_common qmi_helpers mdt_loader camcc_sdm845
panel_simple drm gpio_keys |

|Jul 21 21:45:56 limitless kernel: [ 5533.895732] CPU: 0 PID: 0 Comm:
swapper/0 Tainted: G        W         5.13.4 #1 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895747] Hardware name: LENOVO
81JL/LNVNB161216, BIOS 9UCN33WW(V2.06) 06/ 4/2019 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895756] pstate: 60400005 (nZCv
daif +PAN -UAO -TCO BTYPE=--) |

|Jul 21 21:45:56 limitless kernel: [ 5533.895771] pc :
__handle_irq_event_percpu+0x1d8/0x210 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895785] lr :
__handle_irq_event_percpu+0x1d8/0x210 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895798] sp : ffff800010003de0 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895805] x29: ffff800010003de0
x28: ffffc75e330a3b00 x27: ffffc75e32c02000 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895831] x26: ffff4900496e0600
x25: ffffc75e32c02000 x24: ffffc75e33099a20 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895856] x23: 000000000000009c
x22: ffff800010003e74 x21: 0000000000000000 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895881] x20: 0000000000000000
x19: ffff490049c02900 x18: 00000000fffffffb |

|Jul 21 21:45:56 limitless kernel: [ 5533.895905] x17: 0000000000000000
x16: 0000000000000000 x15: 0000000000000020 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895929] x14: 727265746e692064
x13: 656c62616e652034 x12: 3478302f3078302b |

|Jul 21 21:45:56 limitless kernel: [ 5533.895954] x11: ffffc75e3311a9b0
x10: 00000000fffff000 x9 : ffffc75e31abe5a0 |

|Jul 21 21:45:56 limitless kernel: [ 5533.895978] x8 : ffffc75e330c29b0
x7 : ffffc75e3311a9b0 x6 : 0000000000000000 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896002] x5 : ffff4901b36fa9c8
x4 : ffff800010003bd0 x3 : 0000000000000001 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896026] x2 : 0000000000000000
x1 : 0000000000000000 x0 : ffffc75e330a3b00 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896050] Call trace: |

|Jul 21 21:45:56 limitless kernel: [
5533.896057]  __handle_irq_event_percpu+0x1d8/0x210 |

|Jul 21 21:45:56 limitless kernel: [
5533.896072]  handle_irq_event+0x6c/0x1b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.896085]  handle_simple_irq+0xc8/0x170 |

|Jul 21 21:45:56 limitless kernel: [
5533.896101]  generic_handle_irq+0x3c/0x5c |

|Jul 21 21:45:56 limitless kernel: [
5533.896113]  lmh_handle_irq+0x40/0x50 |

|Jul 21 21:45:56 limitless kernel: [
5533.896128]  __handle_irq_event_percpu+0x68/0x210 |

|Jul 21 21:45:56 limitless kernel: [
5533.896141]  handle_irq_event+0x6c/0x1b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.896153]  handle_fasteoi_irq+0xcc/0x1fc |

|Jul 21 21:45:56 limitless kernel: [
5533.896168]  __handle_domain_irq+0x88/0xec |

|Jul 21 21:45:56 limitless kernel: [
5533.896180]  gic_handle_irq+0xc8/0x148 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896193]  el1_irq+0xbc/0x140 |

|Jul 21 21:45:56 limitless kernel: [
5533.896206]  arch_local_irq_enable+0xc/0x14 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896221]  __schedule+0x2fc/0x8ac |

|Jul 21 21:45:56 limitless kernel: [
5533.896238]  schedule_idle+0x34/0x54 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896254]  do_idle+0x1a4/0x2b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.896269]  cpu_startup_entry+0x34/0xa0 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896285]  rest_init+0xcc/0xdc |

|Jul 21 21:45:56 limitless kernel: [
5533.896299]  arch_call_rest_init+0x1c/0x28 |

|Jul 21 21:45:56 limitless kernel: [
5533.896316]  start_kernel+0x5b4/0x5ec |

|Jul 21 21:45:56 limitless kernel: [ 5533.896332] ---[ end trace
9b7875032d5e8e07 ]--- |

|Jul 21 21:45:56 limitless kernel: [ 5533.896573] BUG: scheduling while
atomic: swapper/0/0/0xffff0000 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896583] Modules linked in:
dm_mod loop tcp_diag inet_diag aes_ce_ccm rfcomm algif_hash
algif_skcipher af_alg bnep lz4 lz4_compress q6asm_dai zram q6routing
zsmalloc q6afe_dai q6adm q6asm q6afe q6dsp_common q6core snd_soc_wsa881x
regmap_sdw snd_soc_wcd934x soundwire_qcom gpio_wcd934x binfmt_misc
venus_enc venus_dec videobuf2_dma_contig nls_ascii nls_cp437 vfat fat
wcd934x regmap_slimbus qrtr_smd fastrpc apr aes_ce_blk crypto_simd
cryptd aes_ce_cipher crct10dif_ce ghash_ce gf128mul sha2_ce uvcvideo
videobuf2_vmalloc videobuf2_memops hci_uart ath10k_snoc sha256_arm64
sha1_ce btqca ath10k_core ath btrtl mac80211 btbcm btintel
snd_soc_sdm845 snd_soc_rt5663 snd_soc_qcom_common snd_soc_rl6231
soundwire_bus pm8941_pwrkey qcom_spmi_adc5 bluetooth qcom_vadc_common
snd_soc_core venus_core snd_compress snd_pcm_dmaengine snd_pcm
v4l2_mem2mem snd_timer snd qcom_spmi_temp_alarm videobuf2_v4l2 soundcore
industrialio videobuf2_common videodev joydev mc hid_multitouch
ecdh_generic ecc cfg80211 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896746]  qcom_rng sg rfkill
qrtr ns libarc4 qcom_q6v5_mss slim_qcom_ngd_ctrl qcom_q6v5_pas evdev
pdr_interface qcom_pil_info qcom_q6v5 slimbus qcom_sysmon rmtfs_mem
bam_dma qcom_wdt fuse configfs ip_tables x_tables autofs4 ext4 mbcache
jbd2 msm rtc_pm8xxx llcc_qcom ti_sn65dsi86 ocmem i2c_hid_of
drm_kms_helper ipa qcom_common qmi_helpers mdt_loader camcc_sdm845
panel_simple drm gpio_keys |

|Jul 21 21:45:56 limitless kernel: [ 5533.896819] CPU: 0 PID: 0 Comm:
swapper/0 Tainted: G        W         5.13.4 #1 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896824] Hardware name: LENOVO
81JL/LNVNB161216, BIOS 9UCN33WW(V2.06) 06/ 4/2019 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896827] Call trace: |

|Jul 21 21:45:56 limitless kernel: [
5533.896829]  dump_backtrace+0x0/0x1e4 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896838]  show_stack+0x24/0x30 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896843]  dump_stack+0xd0/0x12c |

|Jul 21 21:45:56 limitless kernel: [
5533.896849]  __schedule_bug+0x68/0x80 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896855]  __schedule+0x74c/0x8ac |

|Jul 21 21:45:56 limitless kernel: [
5533.896860]  schedule_idle+0x34/0x54 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896866]  do_idle+0x1a4/0x2b0 |

|Jul 21 21:45:56 limitless kernel: [
5533.896871]  cpu_startup_entry+0x34/0xa0 |

|Jul 21 21:45:56 limitless kernel: [ 5533.896876]  rest_init+0xcc/0xdc |

|Jul 21 21:45:56 limitless kernel: [
5533.896881]  arch_call_rest_init+0x1c/0x28 |

|Jul 21 21:45:56 limitless kernel: [
5533.896887]  start_kernel+0x5b4/0x5ec|
