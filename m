Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512404B19A6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 00:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbiBJXjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Feb 2022 18:39:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiBJXjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Feb 2022 18:39:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A55F6C
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 15:39:52 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f23so13344521lfe.5
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=lMYIsxg5Ndi1Qnj1IMfQvcokpUnAkCYVovNl42/0v57BbmjIZhP4ojp0VLhkph8ULn
         pAQH5OIQkzIFk4F3GPp6vfk5ICU2J3Pd8AqrmuPebLRlkZQEjVKUBMam0SEIKaKsJCeS
         0f7Hz9hjj7u0EtQpar2fLZ13UpK+3M7NKNVMr8HtncHt6bswL4tD53K37lsnhoz4tfXx
         3MilCfZX3Wb+MZe5MyC+TLCUH6Vmqm24ivAYGDnTFxYLOIEwcxRK3yhXtsREJ6O6cur8
         tIqQ6cpUljzt3mGIyriJAmc5jyHVRZROb1DmhbZfns19s6My+OB5yTjA7tPW9F5ECsGw
         1uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=fr9xCkyZ0TSWbKyXVbqDbMyIZCO1fuaaJ9X7kNM5FtIiTV3lqkBd1tgbXWCfnRJy+z
         lnX0DPWD+u9EM4xARQo0las+0fhyid4UCKbnmwnAC6SiF2qu7gMzLULX55tTYryqft5p
         jq5C8RYpfdnu8dqb5pasx/hqdJ6LZc7M4ntYYl++Kj6sLC5UqYIZ1jhseXWz1nn9cOZy
         z6x44KmCfIHOCV1nyNEQquyCSEtdQ6wycCMiLkd9mLkQn8ytVcYf7bf+s6Qt7958BSQ5
         Kgcbumza0s2s76ZCjQuhQEGuJjmZxBY5bEXgsbgY9MBmucj0tmiE4QJOQIobrbxLl0Pl
         CapQ==
X-Gm-Message-State: AOAM532dvlc0+l1g9HVQY0UGs43fnIUAyOFUj+Na87uBhxb9fyQN85//
        ulPY4Ar55QDiga0YuUsDT/iU682YCIBFB19lHew=
X-Google-Smtp-Source: ABdhPJz1ozPJ8ma5U92xwbzGP2Soe71dG6jkHALgb2mGGtBkzOxHMhQU3EOZu2pa9p5CY6m2nvM98KvHgwn1VEqlixg=
X-Received: by 2002:a05:6512:38cc:: with SMTP id p12mr421770lft.381.1644536390655;
 Thu, 10 Feb 2022 15:39:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:6792:0:0:0:0:0 with HTTP; Thu, 10 Feb 2022 15:39:50
 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <rogerpakayi@gmail.com>
Date:   Thu, 10 Feb 2022 15:39:50 -0800
Message-ID: <CAL0uRZDXHEMu1y4fNfEv+EeQjTU8Nr9c3YagR2NZiZL=LJ2O7g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 

Hi, please with honest did you receive our message ? we are waiting
for your urgent respond.
