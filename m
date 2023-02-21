Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D969DBC5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Feb 2023 09:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjBUISy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Feb 2023 03:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjBUISr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2023 03:18:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EC10253
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 00:18:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l1so3159937wry.10
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 00:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gELoCGJEkpPy9gdCArOut/mjfO8rPiKercRfU1epEXk=;
        b=Uy4YZj2aoGZcDlVg0GMXgC9+yvfo04PKUc9e926PVFIVTSreZdY82OfbcfyFBkJ/BF
         +8SPWMun7rPL8qD9qjujQR1j6nmm3XBXPks85zxk2snwm/1QxWFqRYTgpBFWL9Y2HzZs
         mxCvbkudw4Ch9JA2GUOHFbPm9VcKjpUUKV0SJtYxeNcxTSfApa4xKu1Yyh20k7FrQXYe
         9EXw9dbNdFoS7644LyfWPFx399raH+3H+jAIccDIdNqJ2ZY6ZB1Aj4ToElh7gzT2g7A1
         yH0/P2D489ztzMvtZHqoPPuZ9tjDD5rPijTQDJE8tQcU725WjUDp/K5EPp64Z31njqfa
         kIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gELoCGJEkpPy9gdCArOut/mjfO8rPiKercRfU1epEXk=;
        b=ZjtEmUkjsXffvYjXIyw3+Wg71qNGaoSfQ757ZTpV/XkqFXttS4Uidn+cOmHZrRjB9Q
         YykQEbpf3pqbiVc5uQ8duhycV9LNindH3iboZk9iYBT4bB+qD0hh0FgfSyv6gerXXGnw
         M/Jgjpv62aL+84UiqA7F6BfH5yqjE3gmE5rfq9q7pbUEz/Zd6frCk0u9R8l+5jHjp2GP
         Pal4K3hKAUsMgsVc/FB3LJqvfY1WbYopvji1vDM77FnobiBkEAZxS/KzQmsmfTi2u34M
         xHLnaeoPQm5oePPLkaEImhIzdaERGYI1D5o1tDHEge/4SuxQoJt1Bo5FW6Ih16K1pWxm
         tEfQ==
X-Gm-Message-State: AO0yUKUOIhXoIcH5G2xwpuxP29mre2VKHiVLHfVwewqb/3AtlW1k6CaC
        oyi6OBkd2l00pYnz7ggob8crh6qPT1HsYsFYh7tsI6AwLilhsQ==
X-Google-Smtp-Source: AK7set9mAvjFATflMJcoGYzLQWAe45P+YDoC3NwYkwmCvSn1rmmiIFRvICxmZDBe4ewwDigq3ULd1HEiJWM/aR55FfI=
X-Received: by 2002:adf:f7c7:0:b0:2c5:507b:657f with SMTP id
 a7-20020adff7c7000000b002c5507b657fmr6897wrq.276.1676967524016; Tue, 21 Feb
 2023 00:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20230210085804.1756449-1-xiongxin@kylinos.cn>
In-Reply-To: <20230210085804.1756449-1-xiongxin@kylinos.cn>
From:   =?UTF-8?B?6YeR5aGU5bCW?= <tgsp002@gmail.com>
Date:   Tue, 21 Feb 2023 16:18:32 +0800
Message-ID: <CAF_YnoQFccBHO_6r78u3eSuH3MfqGGXmywiuVJf-eA=cg295Rg@mail.gmail.com>
Subject: Re: [PATCH] firmware/psci: add .begin implementation for psci_suspend_ops
To:     mark.rutland@arm.com, lpieralisi@kernel.org, kbusch@kernel.org,
        xiongxin <xiongxin@kylinos.cn>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Tian Yaxiong <tianyaxiong@kylinos.cn>,
        Wei Yufeng <weiyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

xiongxin <xiongxin@kylinos.cn> =E4=BA=8E2023=E5=B9=B42=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=BA=94 16:58=E5=86=99=E9=81=93=EF=BC=9A
>
> nvme_suspend() in the nvme pci driver will call
> pm_suspend_via_firmware() to determine whether to use the suspend to
> idle mode or other suspend, the code show as below:
>
> static int nvme_suspend(struct device *dev)
> {
>         ...
>         if (pm_suspend_via_firmware() || !ctrl->npss ||
>             !pcie_aspm_enabled(pdev) ||
>             (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
>                 return nvme_disable_prepare_reset(ndev, true);
>
>         ... /* suspend to idle mode */
> }
>
> The current ARM64 suspend process does not call the
> pm_set_suspend_via_firmware() function, so when PCIe ASPM is enabled,
> the nvme suspend process under the ARM64 platform will enter the suspend
> to idle mode (the irq free is not called), which will cause the nvme
> driver to report the following irq warning during the resume process:
>
> [  189.233188] ------------[ cut here ]------------
> [  189.237791] Unbalanced enable for IRQ 52
> [  189.241705] WARNING: CPU: 0 PID: 2086 at kernel/irq/manage.c:781 __ena=
ble_irq+0x54/0x88
> [  189.249700] Modules linked in: nls_iso8859_1 dm_multipath scsi_dh_rdac=
 scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg=
 snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_eve=
nt snd_rawmidi snd_seq snd_seq_device snd_timer snd joydev input_leds efi_p=
store soundcore sch_fq_codel ppdev lp parport ip_tables x_tables autofs4 bt=
rfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq =
async_xor async_tx xor xor_neon raid6_pq libcrc32c raid1 raid0 multipath li=
near amdgpu gpu_sched drm_buddy radeon video drm_ttm_helper ttm i2c_algo_bi=
t drm_display_helper cec drm_kms_helper syscopyarea sysfillrect sysimgblt h=
id_generic drm nvme crct10dif_ce ghash_ce usbhid sha2_ce sha256_arm64 hid n=
vme_core sha1_ce ahci libahci aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_ci=
pher
> [  189.321740] CPU: 0 PID: 2086 Comm: systemd-sleep Not tainted 6.2.0-rc7=
+ #9
> [  189.328601] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS=
 KunLun BIOS V4.0 01/19/2021
> [  189.337543] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  189.344490] pc : __enable_irq+0x54/0x88
> [  189.348313] lr : __enable_irq+0x54/0x88
> [  189.352136] sp : ffff80000d58bb00
> [  189.355436] x29: ffff80000d58bb00 x28: ffff80000a355a54 x27: ffff001f8=
09910dc
> [  189.362559] x26: 0000000000000000 x25: 0000000000000000 x24: 000000000=
0000000
> [  189.369681] x23: 0000000000000001 x22: 0000000000000000 x21: ffff80000=
a0d2860
> [  189.376803] x20: 0000000000000034 x19: ffff001f80991000 x18: 000000000=
0000010
> [  189.383924] x17: 0000000000000000 x16: 0000000000000400 x15: ffff001f8=
7612578
> [  189.391047] x14: 0000000000000000 x13: 3235205152492072 x12: 6f6620656=
c62616e
> [  189.398168] x11: 00000000ffffdfff x10: 00000000ffffdfff x9 : ffff80000=
823788c
> [  189.405291] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 000000000=
0000001
> [  189.412412] x5 : ffff0020f6f0cb08 x4 : 0000000000000000 x3 : 000000000=
0000027
> [  189.419534] x2 : ffff0020f6f0cb10 x1 : 0000000000000000 x0 : 000000000=
0000000
> [  189.426656] Call trace:
> [  189.429089]  __enable_irq+0x54/0x88
> [  189.432566]  resume_irqs+0x118/0x210
> [  189.436129]  resume_device_irqs+0x1c/0x48
> [  189.440125]  dpm_resume_noirq+0x1c/0x30
> [  189.443951]  suspend_devices_and_enter+0x218/0x8c8
> [  189.448731]  pm_suspend+0x31c/0x420
> [  189.452207]  state_store+0x94/0x118
> [  189.455684]  kobj_attr_store+0x18/0x30
> [  189.459421]  sysfs_kf_write+0x4c/0x60
> [  189.463073]  kernfs_fop_write_iter+0x130/0x1c0
> [  189.467504]  vfs_write+0x284/0x358
> [  189.470893]  ksys_write+0x74/0x108
> [  189.474282]  __arm64_sys_write+0x24/0x30
> [  189.478191]  invoke_syscall+0x4c/0x110
> [  189.481930]  el0_svc_common.constprop.0+0x58/0x190
> [  189.486708]  do_el0_svc+0x40/0xb8
> [  189.490011]  el0_svc+0x2c/0xb8
> [  189.493053]  el0t_64_sync_handler+0xb8/0xc0
> [  189.497223]  el0t_64_sync+0x1a4/0x1a8
> [  189.500872] ---[ end trace 0000000000000000 ]---
> ...
>
> Implement pm_set_suspend_via_firmware() in PSCI psci_suspend_ops.begin()
> for ARM64, so that when doing the suspend process, it will directly
> enter the nvme_disable_prepare_reset() process.
>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: Tian Yaxiong <tianyaxiong@kylinos.cn>
> Signed-off-by: Wei Yufeng <weiyufeng@kylinos.cn>
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 447ee4ea5c90..90d6102d45d7 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -484,6 +484,13 @@ static int psci_system_suspend(unsigned long unused)
>                               pa_cpu_resume, 0, 0);
>  }
>
> +static int psci_system_suspend_begin(suspend_state_t state)
> +{
> +       pm_set_suspend_via_firmware();
> +
> +       return 0;
> +}
> +
>  static int psci_system_suspend_enter(suspend_state_t state)
>  {
>         return cpu_suspend(0, psci_system_suspend);
> @@ -491,6 +498,7 @@ static int psci_system_suspend_enter(suspend_state_t =
state)
>
>  static const struct platform_suspend_ops psci_suspend_ops =3D {
>         .valid          =3D suspend_valid_only_mem,
> +       .begin          =3D psci_system_suspend_begin,
>         .enter          =3D psci_system_suspend_enter,
>  };
>
> --
> 2.34.1
>

This is a bug of nvme under the arm64 architecture, please help to
confirm whether the patch is reasonable;
