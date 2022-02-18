Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E24BC030
	for <lists+linux-pm@lfdr.de>; Fri, 18 Feb 2022 20:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiBRTVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Feb 2022 14:21:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiBRTU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Feb 2022 14:20:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ACB2838D8
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 11:20:42 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7A20B3F1B7
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 19:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645212041;
        bh=H0Iwmd8wCuU9HHukGVMrKzFKF37GPFWQBtO1dM10cGA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fEQ2g1I76rQZAhJEcDW0E3te78PQNitWRg+FViMpTGa6aHQ8Yt9bMPAbjX5S876B9
         Zq3NKbn5ikId+fmJ2eLSike46aA11c09Bnu4GSI+huCOEB69VvspZRQ6uOgR6Fwz9P
         t1WiC4LNai0odYhI+GvhPQ5qrY85oQyVkaXMSeSX8UG1X0FLWFzmiA73dcvZmltQMq
         44H5aDlfkPowcrKtJoZiBAyhrgTA8b6Acsbt0hA43BLCX2Js0IR7wdLs9DSQGwM+y+
         OJ9mbbjy8iZTGRnSVEm4s1uT9KIMGkPWp4R8znapp/rPT0U+wJv4tmKeQ9EKfecraS
         zq68leLgC5zlA==
Received: by mail-ej1-f69.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo3472113ejc.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 11:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H0Iwmd8wCuU9HHukGVMrKzFKF37GPFWQBtO1dM10cGA=;
        b=vjuWp2+QzqIg/Q27oY1pXfxZyU22MrPAhkhqz4CHl6ZyOyNNs5QFpf3nMQCbS0pPqw
         z9TKPyZlpX+IQOVt6kSXhXvQXcNZFhFEGvF6l1KPW7dkSYm+3QA5v0mIFSkYzXTDDSBO
         6aHzj4rR87C/NjXAp/pv4i7qkUS1lR8dTZ680iJgq2a/p3o9sdWNDugY6QB2lRfC/ppE
         f01YeBR+GyQRKhYfsHe+8kfpQjzdza3lVYCIU+zJs8r/k1cH8e9p9YlObxS3SGH/6Egv
         nw5CUeLU0K0QsU8CORelrNIdMihEM0ni2pz6xR5bNUAV87pjTfl+Xgv6zv0Txtl36De5
         Xv/Q==
X-Gm-Message-State: AOAM533oDPr+02XRGikmvzm/mYHk1jzBgv7vG8bU3JVjEdUpO9RxjnEd
        0sEyQzKmjn2L1AouiZSAukdsCOYhf1Ocni5B/hWsyiMd5PuPYLs33L4HU5/AsdmAuivG1BXktz7
        KFiDI4NtooENA5zsZ+d0dM5G8l3OLycTGoSzg
X-Received: by 2002:a17:906:b1d0:b0:6cd:fa02:b427 with SMTP id bv16-20020a170906b1d000b006cdfa02b427mr7463368ejb.99.1645212039291;
        Fri, 18 Feb 2022 11:20:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+3tAag5IIivzTuXFNNLBWIeNlv9ap8rmkimlg4Z9CIQb87t2RY7mnVEypnk+2Ca7rgN3Q6g==
X-Received: by 2002:a17:906:b1d0:b0:6cd:fa02:b427 with SMTP id bv16-20020a170906b1d000b006cdfa02b427mr7463358ejb.99.1645212039146;
        Fri, 18 Feb 2022 11:20:39 -0800 (PST)
Received: from [192.168.0.116] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id l24sm5147643edv.88.2022.02.18.11.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 11:20:37 -0800 (PST)
Message-ID: <91a26d60-abeb-6188-2ed2-1145e52ca36e@canonical.com>
Date:   Fri, 18 Feb 2022 20:20:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] power: supply: max17042_battery: Use
 devm_work_autocancel()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <670ea51361f96035f49852c617325af10ffa07ea.1645205558.git.christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <670ea51361f96035f49852c617325af10ffa07ea.1645205558.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/02/2022 18:37, Christophe JAILLET wrote:
> Use devm_work_autocancel() instead of hand-writing it.
> This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: s/devm_delayed_work_autocancel/devm_work_autocancel/
> 
>  drivers/power/supply/max17042_battery.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
