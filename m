Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBF4CF177
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 06:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiCGFyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 00:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiCGFyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 00:54:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BDB5A0A0
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 21:54:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k92so3219297pjh.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 21:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSv9QIsbfJiXaQGiCs/s147I977dhsO/G6YBwREearQ=;
        b=GnoeXDKSBlOj0dhadpOgL+mFjtabPoQW/YITgrVBmaIFj0cW7156yGSR5Jw/Z4zL+z
         GTzWkX6zfKHZikSLY93sxT22xyWpbKlLagtuawmYCz7SjIH1+fOCqs9hlfSDiaOMNr4X
         GBHwF59iAzBRfbSWYz0ILrF14PAPfFyQ81bBPqsqyWZGth0DUTae7YO2Lsp5DKEeVhIl
         QQjSF2zNo/yqlIJBERJ7pt/3ZRYqf87ZskcxarjXPlPqNeOVpZafjVr9i9fFQdxp+jnr
         iXSsXgEIaEYNref588SmFpBluFCAlPOWeWiimAGNj3Oyc719H2fdl6JQPwo30kUn23pg
         UK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSv9QIsbfJiXaQGiCs/s147I977dhsO/G6YBwREearQ=;
        b=valDFbciCHCbaX5tgX51AXxVNmfCAP4zq75cheaxjujy9HLsYwsI2i5EZS4jLzBXq3
         xmc21B36cbU1a4RjBiJSSTs3o1wzHqKZ1WsBE2CzBgSch9NCxWumusZlSmEn6Nq450YH
         0cZvu57tilxybFkuH6L1nPoWL6kkzAIAjoa0+sGO2srEhDoSZTZrktz6b2t0ePpw4KIl
         Iczmvzz7A293ecOhkFIQlApg2xQ2w6RJHMMdM/GQEzsjf9YBCIfbkcZEIYNCR9xOwM3R
         gEegSrM5Fm3PCJ03V1DSn5P4FomtBrfPR42SAhCJyX0a7wMlXFwvvmqT3iNE5izrwi7d
         +ohQ==
X-Gm-Message-State: AOAM5322OoQvuQ984kzlL5uGgyNj35EsgElyqCOjFFh3sm0NSSizpjRL
        FFp3Is+cIDZQ6DX9/+PqU1+edg==
X-Google-Smtp-Source: ABdhPJyZ2QYIfNhDpZrFweq9RDTxMUQsmX6gTtBZnR88Eo2V3/JoiZYfCyM90fyh37U5e+2/lf59Mg==
X-Received: by 2002:a17:902:e5d1:b0:151:df53:1a5f with SMTP id u17-20020a170902e5d100b00151df531a5fmr6116020plf.134.1646632440222;
        Sun, 06 Mar 2022 21:54:00 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id m79-20020a628c52000000b004f6f249d298sm3448363pfd.80.2022.03.06.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:53:59 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:23:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: unify the show() and store() styles of attr
Message-ID: <20220307055358.cmehf5odv4lo3sdx@vireshk-i7>
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
 <20220307053931.kkhnxrujljynp5cz@vireshk-i7>
 <62259d22.1c69fb81.5ba55.5efaSMTPIN_ADDED_BROKEN@mx.google.com>
 <20220307055216.gh3aiivz7o3tvomr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307055216.gh3aiivz7o3tvomr@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-03-22, 11:22, Viresh Kumar wrote:
> On 07-03-22, 13:50, zhanglianjie wrote:
> > Usually /sys directory under the file, the corresponding Attribute contains
> > .show and .store, and their naming style is filename_show() and
> > filename_store(). But all naming style in 'cpufreq' is show_filename() and
> > store_filename(), So you need to change naming style.
> 
> This is something that is present within the kernel and not exposed to
> userspace. I don't see why we would need to make this change and what
> good it brings.
> 
> I would have supported this if cpufreq itself had different names, but
> for this one, No.

Or is it that you want to reuse __ATTR_RW() and __ATTR_RO() and the
current naming doesn't allow you that ?

I will let Rafael take a call on that.

-- 
viresh
