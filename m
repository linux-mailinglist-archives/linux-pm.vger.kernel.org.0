Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA71913F7
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 16:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCXPOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 11:14:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54632 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgCXPOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 11:14:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OFELjc055861;
        Tue, 24 Mar 2020 10:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585062861;
        bh=l7ghfWCYstg4OWQmwbil6bEMOSOomOvQuKwzXl0urrs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xi2+9VO8c3ngMb6vQYu9llOVBDCazzgFvrzKYmmt8XgAIoCTbODzcy+OxdsTy7Q4X
         H2oxJlPSfYpWyW5JvNqINkYhxYoTk8SPWFGsGi4CPoIKJfTithz8HwduXZYJ1xugYt
         MjnOh8o331QR4X4xfM84yjdPg6tUlrpNBIBFH/gA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02OFELBd096857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Mar 2020 10:14:21 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 10:14:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 10:14:21 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OFEKMv045692;
        Tue, 24 Mar 2020 10:14:21 -0500
Subject: Re: [RESEND PATCH v5 0/3] BQ25150/155 Charger
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>
References: <20200304174025.31655-1-r-rivera-matos@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <eb5f0818-21c7-1b84-b0c9-904bce9721be@ti.com>
Date:   Tue, 24 Mar 2020 10:14:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304174025.31655-1-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bump

On 3/4/20 11:40 AM, Ricardo Rivera-Matos wrote:
> Hello,
>
> This v5 series picks up on the development that Dan Murphy <dmurphy@ti.com> began with the power_supply framework and bq2515x_charger driver. This series incorporates the changes suggested by Sebastien Reichel <sre@kernel.org> in v4.
>
> Datasheets for these devices can be found at:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
>
> Thanks, Ricardo
>
> Dan Murphy (1):
>    power_supply: Add additional health properties to the header
>
> Ricardo Rivera-Matos (2):
>    Add the bindings for the bq25150 and bq25155 500mA charging ICs from
>      Texas Instruments.
>    power: supply: bq25150 introduce the bq25150
>
>   Documentation/ABI/testing/sysfs-class-power   |    2 +-
>   .../bindings/power/supply/bq2515x.yaml        |   99 ++
>   drivers/power/supply/Kconfig                  |    8 +
>   drivers/power/supply/Makefile                 |    1 +
>   drivers/power/supply/bq2515x_charger.c        | 1170 +++++++++++++++++
>   drivers/power/supply/power_supply_sysfs.c     |    2 +-
>   include/linux/power_supply.h                  |    3 +
>   7 files changed, 1283 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
>   create mode 100644 drivers/power/supply/bq2515x_charger.c
>
