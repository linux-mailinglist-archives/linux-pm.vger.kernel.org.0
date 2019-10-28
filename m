Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BFEE77AB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfJ1Rfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 13:35:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37853 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1Rfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 13:35:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id e12so8435956edr.4;
        Mon, 28 Oct 2019 10:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dlbkLkbjNwkW8dWaTCD1qZUiGkWumkyUbrY4hy+PP0=;
        b=PnottxPjqEi8TbNnyEKb6HLm8XjR8T/0aJm9XOa7YYk9xZm0QZblqiSl3R3Lw6rEeU
         Hi8CLL4n13+4DjoscXA1xlUEc2RNkPWoHO0y/gTHzG3kUHslIIXIPLgfzGFbCEiYNs+a
         eFFs7EvnN8RdyFgaDsw8yGImQS3YPhJ/LyGcQm2fYHp9yqhODEasNR5gk0AzaWQSsPJ/
         R1XadkYa8GUfVDvCv9dVlbeUj/GRBcpJxpCmXO5jpoMkuwqBSyrnB6HrErVi7ubv83M4
         OwZO7CMS4kX7XgPZyMGLjvNee10fACbJ7C9VHOUxO1QnewwrZjc70/kyExSXiivy65AD
         X0Yg==
X-Gm-Message-State: APjAAAWokOPmgnO04exvBVg6+lihM+fkseOC01ZI/FdxFk8pyyjU9iuI
        3pXO5ruHK9M9ZHRo7hLBCLTvnBtx
X-Google-Smtp-Source: APXvYqy34BMLtkw8CEAwuKj/UeFjOMF1P1pIJI/GgyugK8iJZkPbVsQ8W9s1ePT5wtn+zaKQGhDcow==
X-Received: by 2002:a17:906:1c97:: with SMTP id g23mr17892494ejh.66.1572284141338;
        Mon, 28 Oct 2019 10:35:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id x6sm601095edc.50.2019.10.28.10.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:35:40 -0700 (PDT)
Date:   Mon, 28 Oct 2019 18:35:38 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, vireshk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 1/3] soc: samsung: Drop "syscon" compatible requirement
 from the chipid driver
Message-ID: <20191028173538.GA14395@kozik-lap>
References: <CGME20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be@eucas1p1.samsung.com>
 <20191028152050.10220-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028152050.10220-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 04:20:48PM +0100, Sylwester Nawrocki wrote:
> As we dropped the requirement of "syscon" compatible in the chipid
> nodes rework code acquiring the regmap to use device_node_to_regmap()
> rather than syscon_node_to_regmap().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/soc/samsung/exynos-chipid.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

