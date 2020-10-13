Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCCE28D2EE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgJMRPX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgJMRPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 13:15:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6662C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 10:15:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l8so59222ioh.11
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=PKr7Vq/qqPUHxm1qGwB++7US2ok17L2SyFB+bd51t5M=;
        b=GBiVfTW9sPA9hnr1lVocuHkd2ol9Y1iG6UqtZTiC3GgTH+UI4hmZelRbhcVPNovwLX
         MpjQEETf901lRykbRjt0oCWLAWQF2DMk4pj3BFEp7NVT5bYZcAdhoiQXJdmWjDzMA7DT
         Eh8zdZLHu3iAdSB/M9Uiy22T161MJ8j1jKQY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=PKr7Vq/qqPUHxm1qGwB++7US2ok17L2SyFB+bd51t5M=;
        b=FR3lCyu0rekSm7dGS20h26HyFW5bQPdqR3cSfhU4P1xLyZO52xEFu4hbDpoDHhs0dH
         Q3QiObWzHm9VgVPP6iUMLdLfAyF5c8QKjez+qNVWaL655qb/UJMS5UwVYwy0J6PbtnKs
         uedyvOeFK24Jx3TTGCIkELoCUGq+Gjw6lG9nhj2eTd/bKcPrlNwA9Gq6xIERDXgqJZNu
         4va1dZT7H1n1CcF9h2kfS9gOSRrHgooYVBas/i27zqHc7q5fACgNQZIPV+yRZaaUBFE3
         8rpsxQK1ewsmOhnqy0kkkTjGRHmNu/BrV5rW5DkqrrZx4ox1gf4FnAaaHdBFmuMvtQxQ
         QcPA==
X-Gm-Message-State: AOAM530F0RCzdg47Yd3tVqWHpPP6W6qG7XJnEYM2bEBl58Flo9vYFIXu
        IpNQLxpAkjF7+mQujFdOoNtP0A==
X-Google-Smtp-Source: ABdhPJzqdvyL97vez1+NJ4KUJFse17yXWg7WveVX5D/7FXNoe1+SckoKGXUNeXTndO4widcJcM8Pwg==
X-Received: by 2002:a6b:8bd7:: with SMTP id n206mr300274iod.13.1602609322123;
        Tue, 13 Oct 2020 10:15:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s77sm485077ilk.8.2020.10.13.10.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 10:15:21 -0700 (PDT)
Subject: Re: [GIT PULL] cpupower update for Linux 5.10-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <396f8b57-50f5-cd20-7a32-40785e669048@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8acb2352-579f-5a5a-840c-d9330807b3f7@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 11:15:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <396f8b57-50f5-cd20-7a32-40785e669048@linuxfoundation.org>
Content-Type: multipart/mixed;
 boundary="------------15D84663CDBC2E5F294D18E8"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------15D84663CDBC2E5F294D18E8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/20 11:13 AM, Shuah Khan wrote:
> Hi Rafael,
> 
> Please pull the following cpupower update for Linux 5.10-rc1 or for
> a later rc.
> 
> This cpupower update for Linux 5.10-rc1 consists of minor fixes for
> spelling and speeding up generating git version string which will
> in turn speedup compiles.
> 
> diff is attached.
> 

Sorry. Here is the diff.

thanks,
-- Shuah

--------------15D84663CDBC2E5F294D18E8
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.10-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.10-rc1.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index c8622497ef23..c7bcddbd486d 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -51,7 +51,7 @@ DESTDIR ?=
 # Package-related definitions. Distributions can modify the version
 # and _should_ modify the PACKAGE_BUGREPORT definition
 
-VERSION=			$(shell ./utils/version-gen.sh)
+VERSION:=			$(shell ./utils/version-gen.sh)
 LIB_MAJ=			0.0.1
 LIB_MIN=			0
 
diff --git a/tools/power/cpupower/debug/i386/intel_gsic.c b/tools/power/cpupower/debug/i386/intel_gsic.c
index e5e926f46d6b..befd837f07f8 100644
--- a/tools/power/cpupower/debug/i386/intel_gsic.c
+++ b/tools/power/cpupower/debug/i386/intel_gsic.c
@@ -71,7 +71,7 @@ int main (void)
 		printf("\tsmi_cmd=0x?? smi_port=0x?? smi_sig=1\n");
 		printf("\nUnfortunately, you have to know what exactly are "
 		       "smi_cmd and smi_port, and this\nis system "
-		       "dependant.\n");
+		       "dependent.\n");
 	}
 	return 1;
 }

--------------15D84663CDBC2E5F294D18E8--
