Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202ED5357D6
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiE0Cly (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiE0Cly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:41:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775592B1AE
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 19:41:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f21so3235584pfa.3
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 19:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wi/hrj07HFnAMs5gRK+PHwzf4ika3I6HtcZW2uUylkY=;
        b=l6jdtyBY/+3YaqjNXCdK1N0PPTs15Wm44V9rglTGE73SBXNJZ+Ku8QxbnQNOoTEcY/
         cjwwYPAz/PfEGSD2aBl2ky3NImrYWWV+cMk6MuG3no7AqceF0DviuoFABB3s8qwFUxDX
         uWDyTlhKDhk3/rO5Fyxffv3QY4Z5wq7a5oIPkdQ1E62oww2KK1vqsC6oe6sL3dSWna4y
         W4o6DM69v/cleKTLXaeplvkvX/Ci1vEkLVv5PxWXHnSq/v3EovPnOxElW+Wq6zNICoES
         xZF2dgvgMuHUeLhXFIJT0P1MBcW9X7RO8GBTI522/wyYroTzqWlrq+ioj2s5Pp7l8maV
         0Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wi/hrj07HFnAMs5gRK+PHwzf4ika3I6HtcZW2uUylkY=;
        b=UyCdbV901mDLt2LzBSk7hEEYxcKVvlM+IcSaSfiBXkAjBidiXWDo/Na2VIENQhztqb
         VN+Op3GMPYKfOI4F78Zl5JsoA3ovMkGP/3nVoETYqZoRW/Orxbjy9D9/9Fbi+1ILbR6A
         RyewsLSbn8U76hTbrimKoq39hUYdh8wEyyxPJL0Nr4tQE6r/EXKcFL4U3o7UhfceVv39
         a9ZvYxPLsR+FwAy71647lsCNI3+JGIFivJD9DrnUk4OIiQ5afiUm55v1OdSU0IkJuDh/
         iBiAkT/aPm1gbzgGQYtzBMJFkpJoFU/OFviFP/FNcBSaGHce5qwXfmkIi3HZAsSn5YQ1
         n4YQ==
X-Gm-Message-State: AOAM532np1Sziuult30C2ZGcT37FtN516v0gzoSgPP69SzTHUo5MuC0M
        U7OF/mPs685PWOthFfpA8OO66w==
X-Google-Smtp-Source: ABdhPJxOzAt+mZYjqO0ZHYfosoiJY1iGop9BuFsgYmewgfpA9DtPs0oYmfuUkPDjpmVqnGeQDsDviw==
X-Received: by 2002:a63:89c1:0:b0:3fb:a1a9:4a6d with SMTP id v184-20020a6389c1000000b003fba1a94a6dmr1751335pgd.521.1653619311964;
        Thu, 26 May 2022 19:41:51 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a634107000000b003c644b2180asm2239700pga.77.2022.05.26.19.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:41:51 -0700 (PDT)
Date:   Fri, 27 May 2022 08:11:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     =?utf-8?B?4oCcUmFmYWVsIEouIFd5c29ja2nigJ0=?= <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: 'schedutil' (possibly) aberrant behavior surrounding
 suspend/resume process (timing/delay/run-away CPU issues)
Message-ID: <20220527024149.n7xpvmz5jvxz3n23@vireshk-i7>
References: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl>
 <20220525052804.rvnp2jinpmz7vukx@vireshk-i7>
 <34KkbDDzdEpklXuY3YwJi95cgyhc44xzV-xQVDRRuKctbmHUdH8Ddm2LMcSUVNVmwtGUaB73-yOqIijCnMFRfh3aYxlKOKcrrRyCHb2uOPw=@dannyvanheumen.nl>
 <20220526032600.dlbrrppqovizwpvs@vireshk-i7>
 <B6Vf9ZGyW3CDcuxpGzU6WbTq7cEi6z-3zrd0JIlop56-d5R3JiD1eQPrLcoM41xDz8_WYWTvQhodW7NLSDURsXl4cRpzsk-UhF17J5Mu5j4=@dannyvanheumen.nl>
 <B3ov-60gJemUh6jis14BfIzBAgiN8DgvrVFZ2RkN891DiItqKwZ6LbXvB72OEwXB489pUOrWnZ-mD17S_nLgsvdguRDRIpcYdLOAjWmpMyk=@dannyvanheumen.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B3ov-60gJemUh6jis14BfIzBAgiN8DgvrVFZ2RkN891DiItqKwZ6LbXvB72OEwXB489pUOrWnZ-mD17S_nLgsvdguRDRIpcYdLOAjWmpMyk=@dannyvanheumen.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-22, 23:35, Danny van Heumen wrote:
> Today I stumbled into the issue with 'ondemand' governor enabled from
> boot. So schedutil does not need to be or have been active for
> this issue to emerge. I still have many questions left, but they are
> not schedutil related.
> 
> The aarch64-based Pinebook Pro issues are not explained yet, but I will
> investigate further and possibly follow up later.

Good. I don't think this is cpufreq related at all. Something else is
going crazy. For simplicity you can set governor to performance with
intel_pstate=passive. That will almost remove cpufreq from the
equation.

-- 
viresh
