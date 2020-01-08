Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A058513487F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgAHQvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 11:51:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38545 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHQvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 11:51:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so3221341oii.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 08:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdLh0q0CRLfYxhapthejt2exqdzrEcPaVCdlxkRkk04=;
        b=sb+kjF6TZPV0iyj9jeV+U6OEVJ++xxzJQj4zVgqyLMSIqLlBAzjcngKgr9GUU5xg0T
         iDY51x69A442mOvC78mBBIzjbyjKxFalxZM+08M+D37tWDdKCVi/pe4bO1yzEGhJT+R4
         kgmv6z4VXDuUR2AWsK/biB11rh2AU5fgdcFh15fZ5/gNwEd+y00bxpduJcqvUSlfNqF4
         Cp0E4jf6yGQ/2m/4MUKTrmKJcHZ9+N4hBjBheXV4CJiBqCIa2VoTxd0TC6633ETEwVGw
         2nvdCsklxN7FFqVP2tvcKGToZPPp7wBLzQSIn3z7waJwCtIppi0OAtjKnkRk5Y14SSKx
         I95g==
X-Gm-Message-State: APjAAAWG19Mz7NSZJYaXLoTdC8a6EzSEQyzVHIbwP+zWc5CL7axmUTDD
        MQbw7W1FFJX/0/eYMTmIatulYtI=
X-Google-Smtp-Source: APXvYqxktcb4YRKjGtL5bhmheJz8yCfT1YRWOVM7beGt7K/GYuieCbHt+omQSSEsKa12Y6gNEQU/zA==
X-Received: by 2002:aca:1103:: with SMTP id 3mr3641390oir.70.1578502312043;
        Wed, 08 Jan 2020 08:51:52 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u33sm1281983otb.49.2020.01.08.08.51.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:51:50 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:51:50 -0600
Date:   Wed, 8 Jan 2020 10:51:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: Add new chips to bq25890 binding
 documentation
Message-ID: <20200108165150.GA30408@bogus>
References: <20200101224627.12093-1-jekhor@gmail.com>
 <20200101224627.12093-3-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101224627.12093-3-jekhor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu,  2 Jan 2020 01:46:27 +0300, Yauhen Kharuzhy wrote:
> Add bq25892, bq25895 and bq25896 to list of supported device IDs in the
> bq25890 DT binding document.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq25890.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
