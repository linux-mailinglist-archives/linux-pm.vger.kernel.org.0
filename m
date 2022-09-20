Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129C5BF0DB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiITXKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Sep 2022 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITXKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2022 19:10:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369F2F659
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 16:10:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d24so3912521pls.4
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Fcm+XfXr78eqc0dgPlS58A1dADCVGldx6M+iMJxUTk4=;
        b=hWnpeF4UfcmqZ4Wh2WQjFQP9I4p5uiA5/md6bfoXMTIIdNrg5FBHD2Kz11xbkllLg1
         MlYK2gWymn2MOl56jIV1xhycl0rY2zwghyOZvWTg5ltD2GB5x1TGBC74cRpmztJmMdSQ
         DVprZ8qohULdilJctbm77jrm6deb3FfJ8T65E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Fcm+XfXr78eqc0dgPlS58A1dADCVGldx6M+iMJxUTk4=;
        b=x5y71pzLrzCJQ53Rmn2v08Pqabi8znmsUInAc17vMknoHQjkNiA/apO2jGEOpCL4Sp
         ku7OqOBlNiOeP0Eeu8L43NdoJlQOctNfQRsVhAAgpYgbKdyzMXKnP7AGOfPRwixaqP1C
         AKf50SkkssdzUMUSPVHIzuukuld40VAKFCl6L/tzZVeW6xLslzodTODdqvj7qA6XfzoW
         3ztmc6kDB5thMHD37oVXz6z3sYcA1jRVymtQcuUwiMpWGfeWG+CQSLqaqCOPgucW++Ro
         STVMdHc3TY1lv1q3d94/F9585kX8ltZDkiqv9bHyg16jib7J/NWWS/AXTLGl426/NqCd
         y55g==
X-Gm-Message-State: ACrzQf0PEfrjMcKd/zsCo4bBM1tSz9Zartj775ULduMrHstsUqA6gDEp
        lT1JZkw124YYKsb/uXMf2nPrmg==
X-Google-Smtp-Source: AMsMyM4Vs8r+F9epOvKPDzNCChxRMpq/jkOL8lwp6ROWR0KPywyY8g2O5MXieKbAneOHF9ltvtTp7w==
X-Received: by 2002:a17:902:cec9:b0:178:5fa6:f3c3 with SMTP id d9-20020a170902cec900b001785fa6f3c3mr1814328plg.83.1663715399638;
        Tue, 20 Sep 2022 16:09:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 207-20020a6215d8000000b00537a6b81bb7sm464526pfv.148.2022.09.20.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:09:58 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:09:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 06/10] PM: hibernate: Add kernel-based encryption
Message-ID: <202209201608.507B5468@keescook>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:22PM -0700, Evan Green wrote:
> Enabling the kernel to be able to do encryption and integrity checks on
> the hibernate image prevents a malicious userspace from escalating to
> kernel execution via hibernation resume. As a first step toward this, add
> the scaffolding needed for the kernel to do AEAD encryption on the
> hibernate image, giving us both secrecy and integrity.

I'd love Eric to take a look at this, just to make sure the crypto API
is being used correctly here. :)

-- 
Kees Cook
