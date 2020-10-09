Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A71288884
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbgJIMS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 08:18:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42246 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbgJIMS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 08:18:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099CIMgM074620;
        Fri, 9 Oct 2020 07:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602245902;
        bh=15gAqw+NsfnwoKS3VkzcBFirfksRlsnPF3W5GMRL+iY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m2Vf9MA51v1aJFBxApnBsZPfi87+xzHx0tn9/afw5J0IBvVcsSXjanW2x35/aAnNu
         h6WrbJCSTy/oO7bCyS9Q5zBEwvIQOBf6PiqedQR8SX0pIw9zSNtDS5YxUzcE2mdTPK
         FXEpZEH8i6E42ljZ2cbODrbLZozkDmY+TL5bRpHM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099CIMe7114662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 07:18:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 07:18:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 07:18:22 -0500
Received: from [10.250.67.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099CIK5d115895;
        Fri, 9 Oct 2020 07:18:21 -0500
Subject: Re: [PATCH v3 2/2] power: supply: bq25790: Introduce the BQ25790
 charger driver
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>,
        <sre@kernel.org>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
References: <20201009121532.GN1042@kadam>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a38c3dcd-4e19-0d99-105c-c2cb0a645eb6@ti.com>
Date:   Fri, 9 Oct 2020 07:18:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009121532.GN1042@kadam>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dan

On 10/9/20 7:15 AM, Dan Carpenter wrote:
> Hi Dan,
>
> url:    https://github.com/0day-ci/linux/commits/Dan-Murphy/dt-bindings-power-Add-the-bq25790-dt-bindings/20201008-234450
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> config: i386-randconfig-m021-20201009 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/power/supply/bq25790_charger.c:170 bq25790_usb_work() warn: ignoring unreachable code.
> drivers/power/supply/bq25790_charger.c:624 bq25790_get_property() warn: should this be a bitwise op?

Fixing both of these now

Dan

