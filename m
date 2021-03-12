Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B798D33916A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhCLPf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:35:28 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:43881 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhCLPfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:35:17 -0500
Received: by mail-wm1-f44.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so12479571wmj.2;
        Fri, 12 Mar 2021 07:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hiZMy3cry06xjnySZkVn2oNvnH6/AnPXTBEJKfK8OlQ=;
        b=g8SuB50I15uQyw1I+NMzuLSOq2xvALzH8iWnHRIbx+5GEhNY6GWdMuRaJzjvEDQVYx
         FWTIphcKGzXMUoGidJVV5w13wL+uTBjHaWdE9jrp5DyfRgrTd8B91jgTkQGauwZN76Tx
         HtczvXZuuPsRQJIPf/FSPEBgD74BLaaRvmLmTQNHkRFXClGudPn6DKt4jjUHo5LE2ldG
         RJecP7ku7e6z+FcjWlLwEEoBda45GZXLVEXv8Cwm+FP1uXSYbIDw+laXpVAmKGO9si9z
         sSV3VtFua1L+U8AW35YO/UMlw3znJQfApHXZe3Z0e2C/0FpbZCcFyThup0sgi0HkMrHT
         AZPQ==
X-Gm-Message-State: AOAM533GxJ+jHRuZdI6ocmXhE+qPC4/8itkIbY1Lrhm/ztKgIuWZ9q8n
        mOVF2+UpaZEHdmEE2Ktnjrs=
X-Google-Smtp-Source: ABdhPJyppRd9R80jV2myTcWaUft3WI+5NQK3H7PByCJHpSLD26X+MmLJkzN7/GwAmJhNfV/r1l9LPg==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr13986592wmk.89.1615563316030;
        Fri, 12 Mar 2021 07:35:16 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i17sm8195254wrp.77.2021.03.12.07.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 07:35:15 -0800 (PST)
Subject: Re: [PATCH] extcon: Provide *extcon_*_notifier_all() stubs for
 !CONFIG_EXTCON
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sebastian.reichel@collabora.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210312141051.blqkm2v2yx6psild@linutronix.de>
 <CAJKOXPeXQS2pZ-siZGP+E3y1Gus5_9-ByAetUD9Mk0UH+t0OYA@mail.gmail.com>
 <20210312145307.mkzkrbehqertfv3r@linutronix.de>
 <29f27256-e5ca-3bbe-4b73-afeac4ff23cf@kernel.org>
 <20210312145507.nssjwwi5qffffcpc@linutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <b4738933-b6a5-8c7e-3890-ea0f64c8e18a@kernel.org>
Date:   Fri, 12 Mar 2021 16:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312145507.nssjwwi5qffffcpc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 12/03/2021 15:55, Sebastian Andrzej Siewior wrote:
> On 2021-03-12 15:53:53 [+0100], Krzysztof Kozlowski wrote:
>> Yeah, it missed the merge window...
> 
> Could you please send it for -rc3?

I meant, the pull missed the merge window. Chanwoo already confirmed he
will be sending it for rc3.
https://lore.kernel.org/lkml/6c40afc8-4ea7-aef7-73fd-8935e2bfe0dc@samsung.com/

Best regards,
Krzysztof
