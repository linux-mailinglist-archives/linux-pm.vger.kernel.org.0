Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748E711732E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLIRxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 12:53:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35057 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIRxl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 12:53:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so13495692edv.2;
        Mon, 09 Dec 2019 09:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UrvHL4BYkHmgmCYtDoJeTxTYIse1XysrLlj41Dvh9n8=;
        b=f/OyBQeV7RS8TMtru1oa6T6nikPaHzlVB0zMu5+Txbxw9qWp3egQMp3L84ipEm0LSO
         xZOP6fAniFLFIDuT1GRrt8cn4nFwC/5gY3YxdZf21/1zmwtmpsh7g//j7iAA3ZTXTiDt
         A5RZwAiPtclrEicckr0D6R05HLhJtITA6MH9lNSC8Gspc7CMvzl4bzoKD3O7IxHNTLIW
         mrPp+N4jwrGPiD1rQKkTKDUE1oM/6wyEatANp0EOncWlv3IZ553G7B3p0BWJvwzkokJR
         jrwZxbAFfg1hNjaBLIGM4rGK+hT9XUK1kbklAP6m3VU+JQOcqoV8UsXUND0e/bGkB9cQ
         iyRg==
X-Gm-Message-State: APjAAAWCZxDP45whYjvU3kAQ5GRf+dqom5bIywpuDz7Gaq9hw/3tvu4f
        DPakymQysvg8xldgYWF7GlE=
X-Google-Smtp-Source: APXvYqz7xZT94bkflIUqchNHC8Bx7fBoGQEEA7qmUQgUgR7AhVj7LrwjuPGVnN/TM4VY1+/+rELM7A==
X-Received: by 2002:a17:906:8394:: with SMTP id p20mr19330863ejx.136.1575914019321;
        Mon, 09 Dec 2019 09:53:39 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id u9sm12129edr.4.2019.12.09.09.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 09:53:38 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:53:35 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     lukasz.luba@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH] MAINTAINERS: update my email address
Message-ID: <20191209175335.GA26324@kozik-lap>
References: <20191209093907.6646-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209093907.6646-1-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 09, 2019 at 09:39:07AM +0000, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> Update my email address to @arm.com in MAINTAINERS and map it correctly
> in .mailmap file.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Krzysztof,
> 
> Could you pick it up, please?

Thanks, applied for current (v5.5) cycle.

Best regards,
Krzysztof

