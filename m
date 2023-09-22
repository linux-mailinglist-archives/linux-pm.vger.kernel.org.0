Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB387ABA9D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjIVUsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Sep 2023 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIVUsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 16:48:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750931A3
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 13:48:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27700d86b8bso1560683a91.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1695415684; x=1696020484; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOhiHOXQ1uklOFPSw21jdDwczFgjMSdMIH7ZmOAcjDc=;
        b=L5i49a3iteCwsW5P8tWcCv2NX6rxK+aOAOwrjhViMWcbbYfa/NSq1VHtfp1yEMEIOP
         xgLrBmdc/a3dLVYYrZoqWO1DoTHKC1q0VRKL2HqmiKImq8wOn8Y//GYMyHtyyyr2ZhxY
         HKCTvJ43tg2JNuaYE0Y5XlSr62qVwIatjMbacvfnb7J6xMRhICjIG2e351wFLt3fCpZR
         RvcU0FeuhKRUehYaqDi65SgGeB0NQrHTcDSS4sC9JbNsee3kqNYaY7sPD3+EruUbTnT7
         AzfkuaROugsX7fNyo4KsjvtUZyeeBD6EJWQB7B4LMVZ2990NyFJEp8PlcXq+ddb34L1z
         11QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695415684; x=1696020484;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOhiHOXQ1uklOFPSw21jdDwczFgjMSdMIH7ZmOAcjDc=;
        b=m29BCXngnYBt074H6cr83pk0sSJgfCdQeWw1jXmpJuAFdI425Z5dcoL+X5mOptyrKG
         xd4ZbRM/xXn0bNhxOkTCksbU55i2W3RyIRW/YR6g6gTVHbPcbDKeNq6AsGkkyy/PmJIR
         FC+lwlXeAmBnPx6CAeg4y3+lbK6CVPQKwEj54d979H+6K39JMmtt4Eop5oFeu+hUUcLk
         CFubaaSt+bF9z9GOpQf2SRNYOLG+5Pohz03wBdjecjqT2r5Qwr99FCnsar/lSgSZovpR
         dC8SsJLsDjFK9NSRQ0CYEvGYhfMJCU9muWLfAZfRIoGIMxTXc2klI9SJylZBgZ4Zq307
         jvmw==
X-Gm-Message-State: AOJu0Yw4ZZicFWMvlV2DafVDSE7sbjVu0BK0r/6+9ubx1p3FRHi79UGJ
        jiPoc3THDAsBZSxk52MxuyfUbQ==
X-Google-Smtp-Source: AGHT+IEPEc1yJxXfHD+qN6OXOXDdUWiePPSfvI6K8rV7O+0obxBsYyKKEc3WD/AtHYp9tEzz4jH8mw==
X-Received: by 2002:a17:90a:728e:b0:268:b64b:f684 with SMTP id e14-20020a17090a728e00b00268b64bf684mr741277pjg.33.1695415683920;
        Fri, 22 Sep 2023 13:48:03 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090abb1700b00267d9f4d340sm5347010pjr.44.2023.09.22.13.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2023 13:48:03 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Wyes Karny'" <wyes.karny@amd.com>, <lenb@kernel.org>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20230922092823.478042-1-wyes.karny@amd.com>
In-Reply-To: <20230922092823.478042-1-wyes.karny@amd.com>
Subject: RE: [PATCH] tools/power turbostat: Increase the limit for fd opened
Date:   Fri, 22 Sep 2023 13:48:05 -0700
Message-ID: <004501d9ed96$16af12f0$440d38d0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLdRauO63O5kGzkuYXvBkOCK34Jtq4gmYpA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2023.09.22 02:28 Wyes Karny wrote:

> When running turbostat, a system with 512 cpus reaches the limit for

Suggest" ... reaches the default limit for..."

> maximum number of file descriptors that can be opened. To solve this
> problem, the limit is raised to 2^15, which is a large enough number.
>
> Below data is collected from AMD server systems while running turbostat:
>
> |-----------+-------------------------------|
> | # of cpus | # of opened fds for turbostat |
> |-----------+-------------------------------|
> | 128       | 260                           |
> |-----------+-------------------------------|
> | 192       | 388                           |
> |-----------+-------------------------------|
> | 512       | 1028                          |
> |-----------+-------------------------------|

The number of open files is a function of what is being "show"ed or "hide"en.
They can also increase beyond the above 2 X (# of CPUs) + 4 number
via the --add directive. 
>
> So, the new max limit would be sufficient up to 2^14 cpus.

Well, not quiet, but the point is valid.

Normally, I would assume that a server with a large number of
CPUs would have set a much higher limit of the number of open
files than the default. I use 131,072 and so this patch reduces the
maximum.

Unpatched:
root@s19:~# cat /proc/47043/limits | grep "Max open files"
Max open files            131072               131072               files

Patched:
root@s19:~# cat /proc/47032/limits | grep "Max open files"
Max open files            32768                32768                files

Anyway:

Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>

>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9a10512e3407..23f1fe58289a 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -6717,6 +6717,18 @@ void cmdline(int argc, char **argv)
>       }
>  }
>
> +void set_rlimit(void)
> +{
> +     struct rlimit limit;
> +
> +     limit.rlim_cur = 0x8000;
> +     limit.rlim_max = 0x8000;
> +
> +     if (setrlimit(RLIMIT_NOFILE, &limit) < 0) {
> +             err(1, "Failed to set rlimit");
> +     }
> +}
> +
>  int main(int argc, char **argv)
>  {
>       outf = stderr;
> @@ -6729,6 +6741,9 @@ int main(int argc, char **argv)
>
>       probe_sysfs();
>
> +     if (!getuid())
> +             set_rlimit();
> +
>       turbostat_init();
>
>       msr_sum_record();
> --
> 2.34.1
>

