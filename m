Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C8596ED2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiHQMxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiHQMxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 08:53:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C82C4A
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 05:53:15 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E2FBD3F043
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660740793;
        bh=2CzUWzuctdvooMp7yxBDN8zIUirPasAN12j6QMVsLHg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=c2PluDckoePaUDsBB6pW9auzeqlMwNRi3PE+HFyjnEuL8Jxl/IuHLxAwvVRtQUVJK
         xaFFJ1ES2MjRCsWXwdXDPeIxlKuOGSHK8adHeMngxJrFruuS+JXcyIj+OJCxqHYFxU
         LdBaTLcDzO+lw7dayFnhli2195eLQ9yysjNhT6108w0QIJhjUuJh/Ro3FEf1xqctsb
         kDRfT2vXyW2GDMjz5e+92+XR8iBuV5XtAFSY4nTfgxVBBJKMSa8ZjZz/Q55CjChsAO
         5QPoDLvo3FSawlXZmC7Ywd5UHmTaTuG7MFtX9kS1BptnGQzxnZRZ1QRa9AuaKDzP41
         vE2wv0oD358cA==
Received: by mail-oo1-f69.google.com with SMTP id y13-20020a4a650d000000b0044886d0101cso5592811ooc.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 05:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2CzUWzuctdvooMp7yxBDN8zIUirPasAN12j6QMVsLHg=;
        b=Y8s026zmyH8HFBqwxLVLeOixsV6Z3bp/iLmtBlJiPOgK1RWkidzm/6cHLIp4+r5Mfh
         20zzNkXUrRazH/+pHeWgTVE/NCabnzKZTQjYPFszcS8PWZccQ2szXUdE0DomekMfxdjC
         AuNQqiSX2JXhzJO7H8xK7+1J+2+mca4gtOZU/0/HGr/w/s2NC5ofRlJUYEYUy9vmzSgY
         SlKz34FpvERztfIYyF/jGyjpUu6vIaKNlHuAnx3j2syPy2dTCUQzIM1RR4Tx43nAsfM5
         24zP+GiqX0Pl6xZIUHC7I9QzW1DVYD7g0rmBmJbDJzXvFi+y8afaUlhluFqtIGrQ11fI
         FNQw==
X-Gm-Message-State: ACgBeo3hOtcYw+rCmvC0SIXIM5STFmBQDazsUPcDT+ksZ0MiZeoY6uwk
        5QiPhNSF+7L9LzSb8V/62yF+R6mV3sxRTH1o0i0H/xbIgaS1arGqFCnc4v0UGrycWCK6FGcGJ7z
        Onu8W9E7/EYeYlb5Rmm/etoPaP39d8jixx1/xFbI2o30SsDzJipBa
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id s31-20020a056808209f00b003448f501f29mr1384703oiw.42.1660740792790;
        Wed, 17 Aug 2022 05:53:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UHpzyeNVPPnQk41J1aN5C0n4mOhOasLlKF+2VLzm7rhCFlIJKjdsuC/Aqi9Dx58s/NFuchk4iKXmWoDbGNmA=
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id
 s31-20020a056808209f00b003448f501f29mr1384696oiw.42.1660740792495; Wed, 17
 Aug 2022 05:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6VowO3WJt4mUJtxJenL8qbxtPFtXGjgiMkckX71bPrfw@mail.gmail.com>
 <YvzDNgBgMiMrfc1M@black.fi.intel.com>
In-Reply-To: <YvzDNgBgMiMrfc1M@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 Aug 2022 20:53:00 +0800
Message-ID: <CAAd53p7HDYz9b9rG236g4MVHAzksOKEOcDZW+MHYi4MoAbO99w@mail.gmail.com>
Subject: Re: How to get "wake up reason" for Suspend-to-Idle
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 17, 2022 at 6:30 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Aug 17, 2022 at 03:08:18PM +0800, Kai-Heng Feng wrote:
> > We are seeing laptops wake up when Thunderbolt dock gets plugged, or
> > even wake up on AC plugging.
> >
> > On Windows these events are logged with "Wakeup Reason", and if the
> > wakeup event is from unplugging AC, the system will be put to suspend
> > again.
> >
> > So I wonder if it's possible to get the "Wakeup Reason" under Linux?
> >
> > '/sys/power/wakeup_count' seems to be insufficient for this purpose.
>
> I don't know if there is a way but unfortunately several systems (or
> their firmware) are expecting Windows style "dark resume" so they pretty
> much wake up each time something gets plugged or even unplugged to these
> ports. Linux does not have similar mechanism at the moment but I think
> at least if you have lid closed it will eventually go back to s2idle.

ChromeOS also developed their own version of dark resume [1], which
checks  '/sys/power/wakeup_count' to decide if the system should go
back to suspend again.
However, if there's any spurious wakeup event occurs during s2idle
like [2], checking 'wakeup_count' alone will put the system back to
suspend, and the system will stuck in a wakeup/suspend loop.

So I think it's safer to implement the mechanism in the kernel, by
implementing .suspend_again() callback for s2idle just like what S3
does.
However, to make the right decision on suspend or wakeup we need a
concrete "wakeup reason", but I wonder how do we achieve that?

[1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_manager/docs/dark_resume.md
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216295

Kai-Heng
