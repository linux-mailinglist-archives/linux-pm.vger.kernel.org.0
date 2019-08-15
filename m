Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2E18F314
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 20:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfHOSSx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 14:18:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36371 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHOSSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 14:18:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so2019670wme.1;
        Thu, 15 Aug 2019 11:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5leAgXssmuJq/e90a7MyYuV3K+kXUHUhhkOK+kGTeCI=;
        b=BnnimLP4qlW5AnZuZHBLi6MSPvT+eQNFFh81qGkSRNGZ4JluQDg+Yi9I4xpi6ns8yH
         r58eWqh1mX6B5QBq9eDcGBUqU+JD76Je0iSidlbSfNheIlaAQvlwKTnlm6WP4ioh4y7/
         +Sh133iZ4Yhc25P6ubrYTHmzgGGVVi6cJEb+dnPRAFdmsuKcCH+y5eUstX2GxnmwsRAY
         4xNSrtXCu/yLCszeloTI3BhxfioLxDYPWyllGvxdWLkty1rdAIeX819VOOG/iiEl4fVA
         LtaCXNZLW7onrL4/mmWsmKwLrNdDWEcAb4VmbK3p20tiG9mazREaF93U+9C1hAHdMuhr
         VNaA==
X-Gm-Message-State: APjAAAV9cD4czObNnB5nZmhV/DKT6+Pup0YA38Lwsy2ZWQaNNzBoxvtQ
        9x+KyvsggXE3vQvxbiS6mHk=
X-Google-Smtp-Source: APXvYqzE6ItclCocP3PgZPG+mo57YgFsf9InExOzUcHhgjzT41/UMFtc8ufAeRAqH3HuEm/VsIuTiA==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr4016971wmc.95.1565893130728;
        Thu, 15 Aug 2019 11:18:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id v65sm2874829wme.31.2019.08.15.11.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:18:50 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:18:48 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 1/9] soc: samsung: Add exynos chipid driver support
Message-ID: <20190815181848.GB14360@kozik-lap>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150850eucas1p2aff64b5edb49ffb6626433de1c9e58ec@eucas1p2.samsung.com>
 <20190813150827.31972-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813150827.31972-2-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 05:08:19PM +0200, Sylwester Nawrocki wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> Exynos SoCs have Chipid, for identification of product IDs and SoC
> revisions. This patch intends to provide initialization code for all
> these functionalities, at the same time it provides some sysfs entries
> for accessing these information to user-space.
> 

Thanks, applied.

Best regards,
Krzysztof

