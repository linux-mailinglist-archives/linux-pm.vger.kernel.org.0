Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB443B224E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbfIMOgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 10:36:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39925 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389605AbfIMOgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2019 10:36:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id n7so29671291otk.6;
        Fri, 13 Sep 2019 07:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:mime-version:content-transfer-encoding:cc:cc:to;
        bh=WQe3sxk7jEHoM6MhJMqflNra51yrlF9TrLwm+43/CtI=;
        b=OWCXhxcK5z+g0uNmAHPzSMSXxOFIqBSKRIyN/ukd5v5BmAUrBKzEFOTL5oQ5UupNWS
         7f0idd020ph+o6rpq6DUGkidtCgKOG4PkF4QDEmz+Z/INsZemywq1fDKRHQUqDEqGXKK
         udPFBH7vPzmWF5Jdp9b0vvi8b8Vsl+P/EmrSoX2smLiF/8QLEOQFW552ae0qe8IMfU6s
         nLmriI2/rxualgHKIy+Re53yM/NfMope8uG+uDvcee5w6QlIRnqaCFYf3zniS4g94Xp0
         swTDjP6qLIosZ0K/AlYSmpZMXIGJIOo93zv0rJ03yJo9UEFKhkRGt0LXdvVnmmWkJCPG
         0cGw==
X-Gm-Message-State: APjAAAU9VhoMmCjmMr4EWfBZAqxuxdFMfYlABVpmyk2DgD4ER/spdQkr
        37s+6h+TsRY6TDmWVl+Ddg==
X-Google-Smtp-Source: APXvYqznYXhUuY9wMJA1kZwpAbctOEANyWf0evGLBf0houriOZBOxRh9w67VoSrSBWRo9z1lP7esoA==
X-Received: by 2002:a9d:62c3:: with SMTP id z3mr41959312otk.194.1568385378735;
        Fri, 13 Sep 2019 07:36:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e3sm9962835otr.73.2019.09.13.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:18 -0700 (PDT)
Message-ID: <5d7ba962.1c69fb81.eabe3.44bf@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:17 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] DTS: bindings: omap: update bindings documentation
References: <cover.1567878413.git.hns@goldelico.com> <35e4f219af5f8bff48e89ece7541f4e4ae6f27a0.1567878413.git.hns@goldelico.com>
In-Reply-To: <35e4f219af5f8bff48e89ece7541f4e4ae6f27a0.1567878413.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat,  7 Sep 2019 19:46:53 +0200, "H. Nikolaus Schaller" wrote:
> * clarify that we now need either "ti,omap3430" or "ti,omap3630" or "ti,am3517" for omap3 chips
> * clarify that "ti,omap3" has no default
> * clarify that AM33x is not an "ti,omap3"
> * clarify that the list of boards is incomplete
> * remove some "ti,am33xx", "ti,omap3"
> * add some missing "ti,omap4"
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt     | 30 +++++++++++--------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

