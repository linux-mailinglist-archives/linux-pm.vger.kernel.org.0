Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB96339066
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 15:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCLOyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 09:54:24 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:44777 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhCLOx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 09:53:57 -0500
Received: by mail-wm1-f50.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so15365111wmi.3;
        Fri, 12 Mar 2021 06:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NiYA2DtRZ3FmDJuWqgReIuiHRN495b9mNzPPsb/S6x0=;
        b=L/GN9gZlmXqDPxU+UlDwu72qfCcrOPB+IFwiqUed7iQKOgaiJ7Tc/fcu6UJm5PlHCh
         zgnxYITuzsKnLzL2YFxVSgyNdwNea3wVGuvLt9RfjF4bU7KNyOX6njodhcDWcKkDgH5l
         ayKPNFFixTT3mPlQFfB41KqWmatZToUEnJJAAhcuG8v1S56hMzlHtJw3JmkeVdJAiKIS
         F5un28+9NS/Xxx97YNt89L+wDHISbFXzUsFYROOsiYEwWONso1qpQCKKWAzA2igeALuS
         1DsoQYCZH1cTDxjtfjHXtJKwQf6HrX9GQdwEAjyxLo7QERGwFAqvNnYO4SjjagLN5yji
         is8A==
X-Gm-Message-State: AOAM530N7bUUGgkrJUmDm5U0vvVKzE6EjNhj8rl6bN1FJMlqTCFSZyTH
        a517Mlb8jy8jqjGIbOHVk+cMm6ATmRA=
X-Google-Smtp-Source: ABdhPJwmmoAuoZAPykQLQ1PIv7638hupMAMvol5E9CRWqruUEA1ClqKJoogdpANIVReyLc28gR2YdQ==
X-Received: by 2002:a05:600c:35cd:: with SMTP id r13mr13609467wmq.186.1615560835667;
        Fri, 12 Mar 2021 06:53:55 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u20sm8807741wru.6.2021.03.12.06.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:53:54 -0800 (PST)
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <29f27256-e5ca-3bbe-4b73-afeac4ff23cf@kernel.org>
Date:   Fri, 12 Mar 2021 15:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312145307.mkzkrbehqertfv3r@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/03/2021 15:53, Sebastian Andrzej Siewior wrote:
> On 2021-03-12 15:45:48 [+0100], Krzysztof Kozlowski wrote:
>> Did you base your work on next?
> 
> no, -rc2.

Yeah, it missed the merge window...

Best regards,
Krzysztof
