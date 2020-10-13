Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8E28D2EB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgJMROD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 13:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgJMROB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 13:14:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED35C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 10:13:59 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y16so828057ila.7
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=SG2WQvOtMm43ZoNXBs6FcBpV1RJ9MUTvb2qsz7f3I8U=;
        b=RAiFSZTMabjB/wmvhXy3hgidNNB9OhJtlp2qNrkoH2/4nX0enbVV3X4GQn/ZAoAEpY
         +Uz84OP1sbt/d5VAMVnifY27q+cQ+ssXEKnwZjCA9zDVXyCn/5x5Bl7JMW8hAULdLadU
         dn0BR7GDSJ4avGogpi2sQv5Uf32BUdQSCKPCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=SG2WQvOtMm43ZoNXBs6FcBpV1RJ9MUTvb2qsz7f3I8U=;
        b=XcaUfvawkHIXZFm6J68ziuZfgmIPoFVPNehxtSmKWaoFEouvPhMm66XsMntH8+h+S7
         LU7yp9KLgy9CoKyLKWYTHH5e/vGD7BfEJWpsxKc5+3sQxgHitSJYiwKXBw+X8h1JJeLj
         KiqT7iofm1Hjx2bFwwuktEDMuU273SGkhLRd+lVVzewAE0D2pgKqFtrjGuqvkMkVAJ4s
         iCxnDiQVwkWjRlioznBjT2tgnLbpOC/oW1KvaKB3RaJEjTJivj/1o8SSzvtBlG8avMao
         jd5VGP8zpleoE/ovHkIw+eqWVrgycv5fqy21P+nhAHxklKlutmz8fLE8N0Ul+oObwIKU
         s7/Q==
X-Gm-Message-State: AOAM532dCQAhcGIhx4x6cFjhXjfgYDWPp7jDeFSxpg1+GXhcf5/eoa/L
        iPHR6O6k2lHUJUKYyPA79QlaYw==
X-Google-Smtp-Source: ABdhPJzQAxuII8UcXb+wyDrOmERSCJ3HKvZ8n12a+UkKuUVN3S32nQIcZf3S9Pu+Xvl1zoHH3Yf3lQ==
X-Received: by 2002:a92:ba44:: with SMTP id o65mr802678ili.255.1602609238548;
        Tue, 13 Oct 2020 10:13:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s10sm321701ilh.33.2020.10.13.10.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 10:13:57 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.10-rc1
Message-ID: <396f8b57-50f5-cd20-7a32-40785e669048@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 11:13:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C51D7BB2B876C01DAAFE7104"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------C51D7BB2B876C01DAAFE7104
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.10-rc1 or for
a later rc.

This cpupower update for Linux 5.10-rc1 consists of minor fixes for
spelling and speeding up generating git version string which will
in turn speedup compiles.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.10-rc1

for you to fetch changes up to 527b7779e5ecabb057089b760140309bdcacc16a:

   cpupower: speed up generating git version string (2020-08-20 13:04:47 
-0600)

----------------------------------------------------------------
linux-cpupower-5.10-rc1

This cpupower update for Linux 5.10-rc1 consists of minor fixes for
spelling and speeding up generating git version string which will
in turn speedup compiles.

----------------------------------------------------------------
Colin Ian King (1):
       cpupowerutils: fix spelling mistake "dependant" -> "dependent"

Martin Kaistra (1):
       cpupower: speed up generating git version string

  tools/power/cpupower/Makefile                | 2 +-
  tools/power/cpupower/debug/i386/intel_gsic.c | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)
----------------------------------------------------------------

--------------C51D7BB2B876C01DAAFE7104
Content-Type: text/plain; charset=UTF-8;
 name="linux-cpupower-5.10-rc1.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-cpupower-5.10-rc1.txt"

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5MTIzZTNhNzRlYzdiOTM0YTRh
MDk5ZTk4YWY2YTYxYzJmODBiYmY1OgoKICBMaW51eCA1LjktcmMxICgyMDIwLTA4LTE2IDEz
OjA0OjU3IC0wNzAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6
CgogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zaHVh
aC9saW51eCB0YWdzL2xpbnV4LWNwdXBvd2VyLTUuMTAtcmMxCgpmb3IgeW91IHRvIGZldGNo
IGNoYW5nZXMgdXAgdG8gNTI3Yjc3NzllNWVjYWJiMDU3MDg5Yjc2MDE0MDMwOWJkY2FjYzE2
YToKCiAgY3B1cG93ZXI6IHNwZWVkIHVwIGdlbmVyYXRpbmcgZ2l0IHZlcnNpb24gc3RyaW5n
ICgyMDIwLTA4LTIwIDEzOjA0OjQ3IC0wNjAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpsaW51eC1jcHVwb3dl
ci01LjEwLXJjMQoKVGhpcyBjcHVwb3dlciB1cGRhdGUgZm9yIExpbnV4IDUuMTAtcmMxIGNv
bnNpc3RzIG9mIG1pbm9yIGZpeGVzIGZvcgpzcGVsbGluZyBhbmQgc3BlZWRpbmcgdXAgZ2Vu
ZXJhdGluZyBnaXQgdmVyc2lvbiBzdHJpbmcgd2hpY2ggd2lsbAppbiB0dXJuIHNwZWVkdXAg
Y29tcGlsZXMuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNvbGluIElhbiBLaW5nICgxKToKICAgICAgY3B1cG93
ZXJ1dGlsczogZml4IHNwZWxsaW5nIG1pc3Rha2UgImRlcGVuZGFudCIgLT4gImRlcGVuZGVu
dCIKCk1hcnRpbiBLYWlzdHJhICgxKToKICAgICAgY3B1cG93ZXI6IHNwZWVkIHVwIGdlbmVy
YXRpbmcgZ2l0IHZlcnNpb24gc3RyaW5nCgogdG9vbHMvcG93ZXIvY3B1cG93ZXIvTWFrZWZp
bGUgICAgICAgICAgICAgICAgfCAyICstCiB0b29scy9wb3dlci9jcHVwb3dlci9kZWJ1Zy9p
Mzg2L2ludGVsX2dzaWMuYyB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo=
--------------C51D7BB2B876C01DAAFE7104--
