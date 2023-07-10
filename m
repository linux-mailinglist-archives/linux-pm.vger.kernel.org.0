Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7673774DCEA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGJSAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGJSAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 14:00:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B616AB
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 11:00:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a412653335so369886b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689012007; x=1691604007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxyuM/wL9q4Oq4EoRKDtXsO7yaeaRmhx3XbbQ+h4N00=;
        b=teOyJTkBJ/LIix85iNK4UNxcm5n602B6h/Yt4krGxuOrH+/hbaborHnRRDvVsiBoeC
         2VZ4eTBX1pc/IVjmH2i1REO12Ud2ZHDM5TMYr8pPhWmF155XYzTXZ/nNlwqyQS6RFsVU
         TebY+dicPcKkCwOKGkIvPrIfWhv1BSDLTlrFjpKO9y4z5gVQIZCHFOqGGh4XJUEIOpkb
         F+J0PIWVyZx+h4FM/bx5HkpqgICycpznJyJsjJYFVoRy+yorOVAmPFulxe/T+/6bN6LW
         hFowNkjScOWxioYSmwrujs5uLa3dN2JN6EVFwp3OAHRQnb0gaWS20eEFjtj0OzZrOyBd
         DRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012007; x=1691604007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxyuM/wL9q4Oq4EoRKDtXsO7yaeaRmhx3XbbQ+h4N00=;
        b=RezA4msMrLH5RtV6Hso0Grgxuwc4A0NkY9peJLABpbzhF0AAb5vl62WSm/xMEyAxCr
         UfeRpU26tmwXHfFyqqtWwbBYwUbB4RqcNjVedjq9Hahxci4pI9TgXF5bAURKid3GksLf
         Pzjzf5MFv0ehn2NgosWVO32pX44veXTa3+D/wkqbeuYOzWwyZ1B2+lrsqAsb1zxEfxQ0
         g9PfFjXL8mLFOOaohBMidJddZrNPnC9VqjBiBxNmgrZkUjZ0ZFEdKpjtz9xevnZctQL/
         qNCIFunY4POae/dte9B/BiLEg9i5GesukW68pzjpnTsCFUi/FTKdTsGj9mi6xhx8d/yB
         /Ytg==
X-Gm-Message-State: ABy/qLZ/CIB1aQLswG+FDJwKg9n99QFkp9aPo3K1t7WUIEN/4Rq7iq9M
        MNQjIBZeoNYY4ZsmBMEqyqilgw==
X-Google-Smtp-Source: APBJJlG/GoNUMdIg7gnp0W+zq3hCMMFp5rWpD4Gd1tm+8tGsENaGeMuMmT6vLVc1016OAyTJ1SmeUg==
X-Received: by 2002:a05:6808:2211:b0:3a1:acef:7e2c with SMTP id bd17-20020a056808221100b003a1acef7e2cmr12528145oib.58.1689012007477;
        Mon, 10 Jul 2023 11:00:07 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id x23-20020a63b217000000b0055c558ac4edsm8694pge.46.2023.07.10.11.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:00:07 -0700 (PDT)
Date:   Mon, 10 Jul 2023 23:29:58 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, mshavit@google.com, quangh@google.com
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
Message-ID: <ZKxHHvBKvJeWiioc@google.com>
References: <ZKYvpgs6p3S7nglh@google.com>
 <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
 <20230707164149.GP6001@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707164149.GP6001@thinkpad>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks Ulf and Mani for looking into this. I could not quite understand
your suggestions here. I believe you are talking about adding a new
helper API. What flag will this API update? Will it be
`dev->power.wakeup_path` itself? Or do we introduce a new boolean flag
in dev_pm_info structure for this?

Also, how about the genpd flag? Shall we re-use the
GENPD_FLAG_ACTIVE_WAKEUP flag? Or create a new one?

I feel that we should come up with a generic name for both the genpd
flag and the power flag to satisfy both the wakeup usecase and the
stay-on usecase. Let me know what you think.

Rafael, can you chime in as well?
