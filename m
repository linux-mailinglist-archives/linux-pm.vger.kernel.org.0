Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9982128EFB4
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbgJOJ45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389050AbgJOJ45 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 05:56:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CFEC0613D3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 02:56:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so3556912ioo.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwqKlxMjr4Klds2iG8cGRuUuF9jYTWUSjbYTfK8A0Bk=;
        b=Q9SUK74p2AJIwylbFimsogUW4DoFwEbiDvYDbABzBLfsQr9blrbTYJZCErDHdjkZYj
         HU7m7HDYq4YUdwoU6XgdXOeAcHjOAg2dQFYVtEi4VsJGRVjvVWVKa2d2TPixWpRp4P2x
         ejRN6aQpupv5/Yr6pdfx0IGe23nPsru6YmiVqjSAUY8DFZMlc7CCtMt3MXsEQBBfVBcZ
         j1l+30u5/gxYqBVM31Mo/9bW6pxdFlRSzlpPBvoSUbr8aCP0FHTVsl5HMzL2URleM4zj
         FgSdvgvk7ywgw2L+pROKVgGvGvuBz66ICFZgTguDWwPlLSA0sGzyfCJCiGsqwBt2Hqdf
         mRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwqKlxMjr4Klds2iG8cGRuUuF9jYTWUSjbYTfK8A0Bk=;
        b=AKjCuOCXmvXeNQTa2CIheGk5xYCxpf6TP+AO2WXZtnIYv7BZg5n9C5bEoquCk0YKxm
         c1ETXkB4iEMVecTLPuuEfnae0lPTGVh9Hdy/kYFTvvLyxp3nmDSBGrRF+GiIDM3Aqu5+
         iHHE2aKQkM/6HLpwnwJG5vR09umSpcpcJOz9WxtkR6PGEcdDQjydHDCepZ+6SnKUNw7S
         XUMM/lMnkyRcvF6vDWYWRQPK9yTDepcfKrBJpVJWPnlro+hCy7sS451V2lon3EmOEQsx
         dUhonBi5YaT0R7JVqwh9B/pdgnbIMHAjNldqoLp4tOqXY0qf/Y9/mzutCc98MsOIfHUV
         k93g==
X-Gm-Message-State: AOAM530QFoVo1vkKGXLRwwyl118pRsPegFCNM7J3AN/l7vvxvAB8pYvo
        iEqUAJ6iZ8tpvgWTIak2C2vo0CE4wsmIYN7uBXHZ0w==
X-Google-Smtp-Source: ABdhPJwhzp33JvhzsU2121fM42Wwi/kr2kmT3ygX25KqlRXuvB9UnkvCm4jKMkxbFsC9A7YeBQkAE2LaglFxC3pWrdU=
X-Received: by 2002:a6b:5c06:: with SMTP id z6mr2542162ioh.49.1602755814502;
 Thu, 15 Oct 2020 02:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7> <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7> <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
 <20200831044132.jb7aflr2sfbart2z@vireshk-i7> <CA+G9fYsLd77Wuz6Fdwr0w4eFvs=rX5ooewrztFtSe7MeyRJeGQ@mail.gmail.com>
 <20200831060203.7guhirtxb72odow2@vireshk-i7>
In-Reply-To: <20200831060203.7guhirtxb72odow2@vireshk-i7>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Oct 2020 15:26:43 +0530
Message-ID: <CA+G9fYv5WKQkDvjZsc+xth54X_MK3qUmuUTXhUDVUHpS3UhNpQ@mail.gmail.com>
Subject: Re: WARNING: at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x4cc/0x5d4
 - on arm x15
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 31 Aug 2020 at 11:32, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 31-08-20, 11:30, Naresh Kamboju wrote:
> > On Mon, 31 Aug 2020 at 10:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 28-08-20, 15:42, Naresh Kamboju wrote:
> > > > Viresh,
> > > > I have applied the v2 patch series on top of linux next-20200824.
> > > > and tested again the reported kernel warning is fixed [1]
> > > >
> > > > [1] https://lkft.validation.linaro.org/scheduler/job/1717615#L1881
> > >
> > > Hi Naresh,
> > >
> > > You meant this one ?
> > >
> > > [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> >
> > I have not tested individual patches instead applied all v2 of 8 patches
> > and tested.
>
> Ah okay, Thanks. That's the same.
>
> To be honest, I wasn't targeting fixing this bug with that version,
> but it went well after all :)

The arm x15 boot failed on Linus 's mainline version 5.9.0.
I have listed the latest commits on drivers/opp/ .

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git commit: 3e4fb4346c781068610d03c12b16c0cfb0fd24a3
  git describe: v5.9-4105-g3e4fb4346c78
  make_kernelversion: 5.9.0
  kernel-config:
https://builds.tuxbuild.com/2BB2g61t29VaadVLXEl4cQ/kernel.config


------------[ cut here ]------------
[   13.530971] sdhci-omap 4809c000.mmc: Got CD GPIO
[   13.535647] WARNING: CPU: 0 PID: 137 at drivers/opp/core.c:678
dev_pm_opp_set_rate+0x4cc/0x5d4
[   13.540752] sdhci-omap 4809c000.mmc: supply vqmmc not found, using
dummy regulator
[   13.548931] Modules linked in:
[   13.559638] CPU: 0 PID: 137 Comm: kworker/0:2 Not tainted 5.9.0 #1
[   13.565848] Hardware name: Generic DRA74X (Flattened Device Tree)
[   13.571982] Workqueue: events dbs_work_handler
[   13.576453] Backtrace:
[   13.578924] [<c11e8338>] (dump_backtrace) from [<c11e86e4>]
(show_stack+0x20/0x24)
[   13.583819] mmc1: SDHCI controller on 480b4000.mmc [480b4000.mmc] using ADMA
[   13.586532]  r7:c1df7f60 r6:60000013 r5:00000000 r4:c1df7f60
[   13.599290] [<c11e86c4>] (show_stack) from [<c11ee004>]
(dump_stack+0xe4/0x104)
[   13.606640] [<c11edf20>] (dump_stack) from [<c034f384>] (__warn+0xe0/0x104)
[   13.613638]  r10:ed33b880 r9:00000009 r8:c0f3f4f4 r7:000002a6
r6:c0f3f4f4 r5:00000009
[   13.621502]  r4:c1a3546c r3:00000000
[   13.625097] [<c034f2a4>] (__warn) from [<c11e9950>]
(warn_slowpath_fmt+0x74/0xc4)
[   13.632616]  r7:000002a6 r6:c1a3546c r5:00000000 r4:ee6c2000
[   13.638305] [<c11e98e0>] (warn_slowpath_fmt) from [<c0f3f4f4>]
(dev_pm_opp_set_rate+0x4cc/0x5d4)
[   13.647132]  r9:ed33b500 r8:ee6c2000 r7:ffffffea r6:3b9aca00
r5:59682f00 r4:ed328600
[   13.654916] [<c0f3f028>] (dev_pm_opp_set_rate) from [<c0f4ac98>]
(set_target+0x38/0x3c)
[   13.662958]  r10:00000002 r9:00000000 r8:c1fc11d4 r7:c1f550c0
r6:ee6c2000 r5:00000000
[   13.670821]  r4:ed328a00
[   13.673370] [<c0f4ac60>] (set_target) from [<c0f45c54>]
(__cpufreq_driver_target+0x214/0x658)
[   13.681938] [<c0f45a40>] (__cpufreq_driver_target) from
[<c0f49208>] (od_dbs_update+0x14c/0x170)
[   13.690764]  r10:c1f2f1c0 r9:ed33bb00 r8:ed33ba80 r7:ed33f740
r6:ed33bb00 r5:ed33ba80
[   13.698631]  r4:ed328a00
[   13.701181] [<c0f490bc>] (od_dbs_update) from [<c0f49f6c>]
(dbs_work_handler+0x3c/0x68)
[   13.709224]  r9:00000000 r8:c1f03ee8 r7:ed328a00 r6:ed33ba84
r5:00000000 r4:ed33bab8
[   13.717012] [<c0f49f30>] (dbs_work_handler) from [<c036d7e8>]
(process_one_work+0x200/0x568)
[   13.725489]  r9:00000000 r8:00000000 r7:eeb32600 r6:eeb2f300
r5:ee69fd00 r4:ed33bab8
[   13.733274] [<c036d5e8>] (process_one_work) from [<c036db9c>]
(worker_thread+0x4c/0x57c)
[   13.741405]  r10:eeb2f300 r9:00000008 r8:c1d03d00 r7:eeb2f318
r6:ee69fd14 r5:eeb2f300
[   13.749267]  r4:ee69fd00
[   13.751819] [<c036db50>] (worker_thread) from [<c0375550>]
(kthread+0x144/0x170)
[   13.759252]  r10:ee17be7c r9:ee69fd00 r8:c036db50 r7:ee6c2000
r6:00000000 r5:ee6ab1c0
[   13.767116]  r4:ee1c55c0
[   13.769667] [<c037540c>] (kthread) from [<c0300174>]
(ret_from_fork+0x14/0x20)
[   13.776922] Exception stack(0xee6c3fb0 to 0xee6c3ff8)
[   13.781997] 3fa0:                                     00000000
00000000 00000000 00000000
[   13.790216] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   13.798433] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   13.805079]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c037540c
[   13.812945]  r4:ee6ab1c0
[   13.815566] ---[ end trace 3876693f0f796f8e ]---
[   13.820213] cpu cpu0: multiple regulators are not supported
[   13.825836] cpufreq: __target_index: Failed to change cpu frequency: -22
<>
[   15.409753] ---[ end trace 3876693f0f796f94 ]---
[   15.414449] cpu cpu0: multiple regulators are not supported
[   15.414469] usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
[   15.420054] cpufreq: __target_index: Failed to change cpu frequ#


$ git  log  --oneline drivers/opp/
757e282188f0 Merge branch 'opp/linux-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm
a5663c9b1e31 opp: Allow opp-level to be set to 0
cb60e9602cce opp: Prevent memory leak in dev_pm_opp_attach_genpd()
0ff25c99042a opp: Allow opp-supported-hw to contain multiple versions
2c59138c22f1 opp: Set required OPPs in reverse order when scaling down
60cdeae0d627 opp: Reduce code duplication in _set_required_opps()
475ac8ead803 opp: Drop unnecessary check from dev_pm_opp_attach_genpd()
3a5578784d1e Merge branch 'opp/defer-probe' into HEAD
90d46d71cce2 opp: Handle multiple calls for same OPP table in
_of_add_opp_table_v1()
763700f5e0fc Merge branch 'opp/fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm
922ff0759a16 opp: Don't drop reference for an OPP table that was never parsed
dd461cd9183f opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
8aaf6264fc7f opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
f3364e17d571 opp: Split out _opp_set_rate_zero()
10b217365b94 opp: Reuse the enabled flag in !target_freq path
72f80ce4ef9b opp: Rename regulator_enabled and use it as status of all resources
a4501bac0e55 opp: Enable resources again if they were disabled earlier
d4ec88d20558 opp: Put opp table in dev_pm_opp_set_rate() if _set_opp_bw() fails
8979ef70850e opp: Put opp table in dev_pm_opp_set_rate() for empty tables


link,
https://pastebin.com/9kDPEFLU
https://qa-reports.linaro.org/lkft/linux-mainline-master-sanity/build/v5.9-4105-g3e4fb4346c78/testrun/3308561/suite/linux-log-parser/tests/


- Naresh
