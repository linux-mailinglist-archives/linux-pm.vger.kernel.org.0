Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF95814C2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiGZOEj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiGZOEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 10:04:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231E28E0D
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 07:04:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c13so6707412pla.6
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=k0F7oc8seKiPKmNxfq0oolVNkZvtrip4h5ECu86SXoQ=;
        b=Y3fJVpEPWp1ytk9SgVJnDRJiz4VGtU0srJR1k9laUIxro0D+rWRIVnagflXMwRMGf3
         CSlZ2dN96SJyBCt0dHjBZVE/c3gPAm9YY1lMifye4EGqsteFQ8STiqbc4D3S5GVNOsk2
         0feh1ERhP+1YQQ2rShQXa4y7Ut7uNU0aRB1IVM5tgvUm0bHJz4Kv+NRXJC1tDs4z/RHv
         kabGceV2+uNvZPB1AbDLbZBIPD/HZ15FH8lzJahhNi31+WrZR36Be7q3I/YJMOO020uA
         VNdmKZHnN+H2792AksWf6sXnlteHx4oLN6zL+8nHwx2bPc4apRyJNdTBv4pHhFrJmBIb
         A9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=k0F7oc8seKiPKmNxfq0oolVNkZvtrip4h5ECu86SXoQ=;
        b=LdpcOLqICvpy+wgRyZ7onHsWTgAbzGJ4Sb2n4r2FKlzon4C5PAZRoQIHEiK9MTgNd6
         Vl5L7oVNV7vO4njYDeJKggubQEqb69Ja46vglF7BBYYjGUhKkkH41wfDDlR++tofS+ik
         YRcdXj0JaVVlc1Ef1TC4JrUNHNO/o+Ot9AVTnk8OvekK1F/mI1pFRmgNJf4cQjyGTLnX
         RBH5N6Iba1/RGgoCiBET8/Ud1p20NgcmoWDwci+j4+tmUlxlzUpwJSr4GHMlS1wZhUsa
         2HBZBerhp/NlFsxKq/Bq1U4CLeWxZXIUB73oPyu3v6I1DOwOxjFGxGII/MLh2HSe6ZP2
         YRBQ==
X-Gm-Message-State: AJIora9nOHpkwdKuQGp+tJRTRdMxRQBBLJsf24a+Ic1R6fQ8+Lh+fnPG
        uJ3nIZ4KcYJsTqDy8xvz7Clvetf+w17vFA==
X-Google-Smtp-Source: AGRyM1t+ksOZt2maiyNdCoWRLFj3SOkT877ZUTq9YWy2JWPALcF3gngeBQtJtU3Nt58/4s8p3/tY8Q==
X-Received: by 2002:a17:902:b488:b0:16a:7013:69f0 with SMTP id y8-20020a170902b48800b0016a701369f0mr17209733plr.118.1658844263610;
        Tue, 26 Jul 2022 07:04:23 -0700 (PDT)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b0015e8d4eb1d7sm11589381pll.33.2022.07.26.07.04.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2022 07:04:23 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Ronald Warsow'" <rwarsow@gmx.de>
Cc:     <linux-pm@vger.kernel.org>
References: <485de1a2-4e6d-e458-7c1e-b1cc22600304@gmx.de>
In-Reply-To: <485de1a2-4e6d-e458-7c1e-b1cc22600304@gmx.de>
Subject: RE: idle CPU freq with kernel 5.19-rcX
Date:   Tue, 26 Jul 2022 07:04:26 -0700
Message-ID: <001101d8a0f8$9e2ea420$da8bec60$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIl8n/ujytZ6gJxk1g2ViY0Xc1Iz6z2ByOw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2022.07.25 14:30 Ronald Warsow wrote:

> compiled kernel 5.19-rc8 with the same config as with 5.18.14 on Fedora 36
>
> I see with my Intel i5-11400 (6 core with HT) running

I looked that processor, the base frequency is 2.6GHz.

> while true; do for i in /sys/devices/system/cpu/cpufreq/policy*; do
> FREQ=$(cat $i/scaling_cur_freq); echo $((FREQ/1000)) ; done; echo -e
> "\n"; sleep 3; done
>
> as idle CPU Freq.:
> - kernel 5.18.11: mostly ~800 MHz on all
> - kernel 5.19-rc7 mostly ~2600 MHz on at least 3-4

Those results are correct and expected for a relatively idle system.

> no issue in dmesg
> no programs running wild
>
> what is wrong/my mistake ?

Nothing wrong and no mistake.

As of kernel 5.19-rc1 when a CPU frequency is stale due to idle sleep,
the nominal base frequency is listed. This behaviour is now similar to
what is listed for/proc/cpuinfo.

Please review the related email thread (6 emails):
https://lore.kernel.org/linux-pm/005001d85413$75e5dce0$61b196a0$@telus.net/

Here is an example from my idle i5-10600K CPU @ 4.10GHz

First, Kernel 5.18:

doug@s19:~/kernel/linux$ grep MHz /proc/cpuinfo
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 800.093
cpu MHz         : 800.056
cpu MHz         : 800.029
cpu MHz         : 4100.000
doug@s19:~/kernel/linux$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
800233
800239
800122
800084
800517
801667
799822
800232
800367
800856

Second Kernel 5.19-rc1:

doug@s19:~/kernel/linux$ grep MHz /proc/cpuinfo
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 800.001
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 4100.000
cpu MHz         : 800.166
cpu MHz         : 4100.000
doug@s19:~/kernel/linux$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
4100000
4100000
4100000
799943
4100000
4100000
4100000
4100000
800051
4100000
800007
4100000

... Doug


