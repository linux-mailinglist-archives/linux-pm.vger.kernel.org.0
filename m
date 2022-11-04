Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D761A022
	for <lists+linux-pm@lfdr.de>; Fri,  4 Nov 2022 19:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiKDSjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Nov 2022 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKDSi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 14:38:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55611148
        for <linux-pm@vger.kernel.org>; Fri,  4 Nov 2022 11:38:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p12so181959plq.4
        for <linux-pm@vger.kernel.org>; Fri, 04 Nov 2022 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxUQcGD1ekL/2d9GXVQdlQ0tteAYOQEOTDd6IVlVtPY=;
        b=GjlhU7IoqaY718RNOR7DqWTG20zF6kOt5wgWynudn0ITp0+zDVD5QosZuVb9DcNI1E
         uLg7ZOVZiESDg9QBf+b2QS/Pn8Hc0gkXnTqzle1PVe0v7nwVonxi/nK9dqBJhmAlASAJ
         tuMCJ67J0Eu/2HZM0qT0wURiQPbKt5+sQ88DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxUQcGD1ekL/2d9GXVQdlQ0tteAYOQEOTDd6IVlVtPY=;
        b=42B6I4jhtGfpoAkqhmfgCNnQmazz/iF0fY+stDF845DIBv4EC2BJ08MiCCxYwCcDTE
         YPr+5xhnaoRQkMSGZM+ycNRYekPkJBOBoRA37jwB3febBEvRKqgfdGXygWGv111fTHpe
         4ZPYy1II8c57r0D3PUlQQDZMu1r1zzqjieqYE4zcmAijwj5QTJfC4zLWr4E8sr8lFsYg
         pn2ILKaCWxJzdDe1JWCad8si+FEdsjdCNmUNSRRMWlSIvYLPGE+tTmmCat9thWTG4CMT
         eSiHyPyMqB7pCQdPRqRviqbMN+U5Hh/yF54e0cwzwuYHSFhXCIjI4mFGa9U+6Ei9ZKN/
         JblA==
X-Gm-Message-State: ACrzQf2Vo5yuAl5EO74rwG9G0fbfMq+1E3qpVQKYGX++/cQWCIVi57k+
        xKK5a40JPHc8rH3t6bDBX7DiDE7z0eTphA==
X-Google-Smtp-Source: AMsMyM4Ns1LVB+0LABBHOJzWrjQNzMAUk0lZthXzQw3TR/Rcm2joh9j3MHvMTSFHaR/HR+59oKPNuw==
X-Received: by 2002:a17:902:8a90:b0:186:b145:f5ec with SMTP id p16-20020a1709028a9000b00186b145f5ecmr37462611plo.103.1667587137752;
        Fri, 04 Nov 2022 11:38:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17-20020aa797b1000000b0056bcc744bdbsm2957812pfq.203.2022.11.04.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:38:57 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:38:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 07/11] PM: hibernate: Add kernel-based encryption
Message-ID: <202211041135.EAC889BA08@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:15AM -0700, Evan Green wrote:
> [...]
> +config ENCRYPTED_HIBERNATION
> +	bool "Encryption support for userspace snapshots"
> +	depends on HIBERNATION_SNAPSHOT_DEV
> +	depends on CRYPTO_AEAD2=y
> +	default n

"default n" is the, err, default, so this line can be left out.

If someone more familiar with the crypto pieces can review the rest,
that would be good. :)

-- 
Kees Cook
