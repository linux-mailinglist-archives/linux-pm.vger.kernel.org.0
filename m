Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863465BF108
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 01:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiITXY1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Sep 2022 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiITXY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2022 19:24:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516575482
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 16:24:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c198so4147838pfc.13
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YBxKYtku/8oBqXa6wknfhjy5g8vzVr4YX5LTwcm1bbI=;
        b=gD+f9UOZYo3ekJbZUpFYgJ/HfGJ3fd5gvcLeDrzeVaBYB8VWTCKUuiMS0S396sBJ6X
         KpDzMKtkwKRdJNS6Fbjyx6EOV6BmQStq678NppE46oVHcCnQ2pGndSnsbyZDK+Ejy+Qj
         EtfxzfsAymKrFf4r4Wv/XpQ48uxJNUbG/MkkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YBxKYtku/8oBqXa6wknfhjy5g8vzVr4YX5LTwcm1bbI=;
        b=xSet6ywCdEqXYo66HCoUbxW6yAWWIACC70IAG2Bwbb8Wf6vAXmq33XD7VtPwVtnWdo
         Pm0v3ufjkxgyz6qEgKNAmyj7hXJLt2gGr3GVrTLigWbmzC4Mqm48cg5V4PIvPUfcLdZ8
         GgAVJx6QupUshdYg/P4ff2KEbKY92doCNMRtSl/75tzZzJpeSndKt0d2V1V+sw9uLjP5
         dF5h3sgAIsix0AUKLNhwMwOuogGUi7rnV/rNeurnED8bppRNwJ2+nMkwuyvApBbVjYEK
         fGws3TddlMljqf6d4gVgMvHnoD6KL/m2VdUYXHy0dCTjGpDnmlytsueljNcEe3gKeTln
         XUsQ==
X-Gm-Message-State: ACrzQf0ywqhnubCZOM7XjgqM4Sye1y8oyUcvWvML3KuIVhk0vVR8/5dM
        6YmkY7H98uDH1VJ9qSbwf+adJg==
X-Google-Smtp-Source: AMsMyM5uBrWLdMDVSDXHfRBiUgynAOmM97uKnPLCvt5fOVHCz/I7t0Kb31PyQDclJDkq7Bc00gKLmw==
X-Received: by 2002:a65:6742:0:b0:43a:827d:c0 with SMTP id c2-20020a656742000000b0043a827d00c0mr7944368pgu.537.1663716264218;
        Tue, 20 Sep 2022 16:24:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20-20020a6567d4000000b0042b291a89bfsm536149pgs.11.2022.09.20.16.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:24:23 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:24:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com, Hao Wu <hao.wu@rubrik.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, axelj <axelj@axis.com>
Subject: Re: [PATCH v2 10/10] PM: hibernate: seal the encryption key with a
 PCR policy
Message-ID: <202209201620.A886373@keescook>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.10.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.10.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:26PM -0700, Evan Green wrote:
> The key blob is not secret, and by default the TPM will happily unseal
> it regardless of system state. We can protect against that by sealing
> the secret with a PCR policy - if the current PCR state doesn't match,
> the TPM will refuse to release the secret. For now let's just seal it to
> PCR 23. In the long term we may want a more flexible policy around this,
> such as including PCR 7 for PCs or 0 for Chrome OS.
> 
> Sourced-from: Matthew Garrett <mjg59@google.com>

If it's a total rewrite, I'd say use:

Suggested-by: Matthew Garrett <...>
Link: https://lore.kernel.org/of/what/it/was/based/on

If it's built on an existing patch, I'd say use:

Co-developed-by: Matthew Garrett <...>
Signed-off-by: Matthew Garrett <...>

But I defer to what Matthew thinks. :)

Also, if you don't hear from Matthew, maybe ping his mjg59@srcf.ucam.org
address.

-Kees

-- 
Kees Cook
