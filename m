Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99E46B6E6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 10:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhLGJWP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 04:22:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35922
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233726AbhLGJWO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Dec 2021 04:22:14 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4AA124004A
        for <linux-pm@vger.kernel.org>; Tue,  7 Dec 2021 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638868724;
        bh=mbVZsPIKFmlo4NdLQ32VSh3peIplR0eL3tdmg/4c8Qc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=U6gu73HkHd2dN3Qeu+fI9ZHS1qrwFpu4j1sYz6S/nkjZKRCcgp1oWuoWxJ6qGbdW8
         FziQ64OYfT3Q7qCjvchem2rjosCAFQt4B1URQOpbsdfSbwmr867bnpLIINMjw4lh+K
         Z1iq0dbxlFHJIu+OEcbmg+leZVk15YLa6KOcUdLfygdk5PqQdStHOcSevksDDlP9TQ
         OGaZH4MCrULpJNM9eHFbriEYirgtI7DBr1GaTdVCEU71/5mxTRMixqqXU9DSjhadcf
         QyZKe6AsanRL+69smh3UaIRKGZe8Q8ndhbgww7r6bpKdduquQ874VtWRTcEjl3Wa+A
         in31+sPzOE+Gg==
Received: by mail-lj1-f199.google.com with SMTP id h17-20020a05651c125100b0021ba28cf54dso4298897ljh.22
        for <linux-pm@vger.kernel.org>; Tue, 07 Dec 2021 01:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mbVZsPIKFmlo4NdLQ32VSh3peIplR0eL3tdmg/4c8Qc=;
        b=HyJaYfP7n5B08qAxZJmVesDR7aDP1JugtUjn4HspKIW58ia8Et6hjil2ZeK6eiKPBn
         FxhA23o+p2q8RSfVrU2yhLXzvLuhDVg7QocGf4n+4JumuzSJaaPuG25TlxeY3wvO7gWZ
         5oEBi/OqxaAE26sb7TOSxkxpcC47oFZ99umwraNR9iLXC2YbCaP8d27hf8kcZKdp5/oO
         zQZa/bbcdX01T0d0PgLZqgESe6xb0+uzItD/Wo0NgHLQ7zxNv5qMizwttIfixW5EK66T
         SD6Ai4aASbMbk7Z31n3TodGA36adCMWbsdw4bSOmVl58Cji4TszBDMJ1RToou+FfDdYw
         1cxw==
X-Gm-Message-State: AOAM531FZPJAxOB5nN6nE7tF1YfnRKvkN1xh27vSstQO078yqIK0eRjr
        jk6VHIw5ksip1LBeADm4PZxhgnxukERw+uE0z0ZM8kLcGgu0WV5l6U/tGOClZU5Z5VJ0yxRYjxO
        FWPaEu1rUT4wCeyp9pbwQq+pSMh14WECk1iQc
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr40346916lfo.174.1638868723702;
        Tue, 07 Dec 2021 01:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE/X3GbUfZYbh0b1cJH+6HgAy41W8jeJ0LU1fZHzlDTEz3mdy4mHHqcZGQE/cHscY2fRtLzA==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr40346902lfo.174.1638868723556;
        Tue, 07 Dec 2021 01:18:43 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b12sm1621027lfb.146.2021.12.07.01.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:18:42 -0800 (PST)
Message-ID: <78ce61a9-b345-437a-df02-49951eb3f31e@canonical.com>
Date:   Tue, 7 Dec 2021 10:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 10/11] tty: serial: samsung_tty: Support runtime PM
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124074625.182815-11-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211124074625.182815-11-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/11/2021 08:46, Hector Martin wrote:
> This allows idle UART devices to be suspended using the standard
> runtime-PM framework. The logic is modeled after stm32-usart.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 93 ++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 34 deletions(-)
> 

Looks good.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof
