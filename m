Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337D72D0066
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 05:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgLFEKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 23:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgLFEKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 23:10:10 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE47C0613D4;
        Sat,  5 Dec 2020 20:09:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so6693316pfh.7;
        Sat, 05 Dec 2020 20:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bjb3siksjCQxhh7o1xTwvr++qhqZ5Ukvote3GZa+jqw=;
        b=KOHeAAgDo0eHYW0Zk9uWp2ZvAyXCfE8yYEVlwMUbJfMcNWmJfvd21AJHKMZ0ck/q5I
         z43qeEDUjAWnRiUzjK9DgzG3ayisnGDNuYDp6BWG60q4MnexXncKBie/7ahrPypBo644
         LT+O04lap68ike/H1T/X4JF0buT0jtCk12i0ByALZFMiXwbXAbwYSWvuNa2JIuH/reia
         uESsqWSAPGN5vM2dNEJij4TOyMu7Qm7Lc1klRyky7gm3xWM11MPhgpJUWwnlGz1XPuwc
         VkIcEnfnBcvz0I89gPxoFqN1FFiBt6Dwu9qFKHKzUWwKX1DbJtntRmPJovdbuQDAnj1a
         YYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bjb3siksjCQxhh7o1xTwvr++qhqZ5Ukvote3GZa+jqw=;
        b=IPYAThCbMtCOoxvwxDynm01WgRoI+ptsi8xeCmdkjgZqSYzR2T2ziKSEunGloD8Z8D
         0kIKYfUpOpRus8pdGeSbWMY9HDwmBFJNj72joDuW4xBz0+jPlnoeC1HdkVAfs1thUkjt
         sAAYszgALhv+iagYHH2WfvFNy6hBbmmWsWvb1FiprZc5ri6bc94PAreGSkoTwvH5PHPA
         IAc70cG+laEN3ybrEyGFlhVZqtgOnebZOIQwofPWL/pTUgqazJoShW8D/r739YLzDaLz
         0XDzgYnz0uC1AOP7cVqno2umyqncBBBfzoY6TTqiIVnUaXWREJs5T75c9aoAOUu6EyO3
         TH8g==
X-Gm-Message-State: AOAM532Po3IwvHozHQ3KUpDgHzsmHEpqpdB08WwUe/jmcjrfBjfXOEVe
        RaRv8KtkXQndv9tFayL1MVCIUlUxAPs=
X-Google-Smtp-Source: ABdhPJz/YEITyD7MdfpgzUNYmvtvjp8X5PGZEALctAPo9bkKRJ6t+7KMGGo/iArVDHFezgEB04ZVtg==
X-Received: by 2002:a17:902:d682:b029:da:c739:ce14 with SMTP id v2-20020a170902d682b02900dac739ce14mr10342893ply.61.1607224403024;
        Sat, 05 Dec 2020 19:13:23 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id y9sm6382998pjj.8.2020.12.05.19.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:13:22 -0800 (PST)
Date:   Sat, 5 Dec 2020 19:13:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] input: atc260x: Add onkey driver for ATC260x PMICs
Message-ID: <X8xMTwaUYx+s1BG7@google.com>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <fb61c36b7a8449d76767f148f2d43447294d5038.1607216141.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb61c36b7a8449d76767f148f2d43447294d5038.1607216141.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 06, 2020 at 03:27:06AM +0200, Cristian Ciocaltea wrote:
> The Actions Semi ATC260x PMICs are able to manage an onkey button.
> This driver exposes the ATC260x onkey as an input device. It can also
> be configured to force a system reset on a long key-press with an
> adjustable duration.
> 
> The currently supported chip variants are ATC2603C and ATC2609A.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v3: 
>  - Integrated Dmitry's review:
>    * Dropped the logic around the check for 'pdev->dev.of_node'
>    * Renamed 'ret' variable in 'atc260x_onkey_probe()' to 'error'
>    * Used 'dev_dbg' instead of 'dev_info' on status KEY_RESET_DISABLED
>    * Dropped 'input_dev->evbit[0] = BIT_MASK(EV_KEY);'
>    * Removed IRQF_TRIGGER_HIGH flag on 'devm_request_threaded_irq()'
>    * Implemented open/close to mitigate the racing issue in
>      'atc260x_onkey_remove()' which has been dropped now
>  - Removed the unnecessary driver compatibles
>  - Used 'reset-time-sec' property of the parent device instead of
>    'actions,reset-time-sec' of now obsolete and removed 'onkey' DT node

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge with the rest through MFD I suppose.

Thanks.

-- 
Dmitry
