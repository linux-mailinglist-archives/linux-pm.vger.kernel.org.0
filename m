Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05821CFE39
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgELTZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 15:25:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58672 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 15:25:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CJP9p0051504;
        Tue, 12 May 2020 14:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589311509;
        bh=qco4Ehag47XBbOtqdypXMcw/aI+7BZU8vseTUs83r2E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JoL+6eEAfOb0mk7S5l9XZ5VI0zQfoJcuFF/oB93FpBNAv1x0iPk6Vps0wxYbNAMhm
         SXNlbALdGiUQsndfF15/UQwM4PYtsgO8Q3qbk2YYekyxuDd+GtWjrIhYFT1tIL3FOY
         qToQDcfJscjx66NrevyG0pNX6x/1fygoECqUjW1Q=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CJP9Aa058134;
        Tue, 12 May 2020 14:25:09 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 14:25:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 14:25:08 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CJP87v088988;
        Tue, 12 May 2020 14:25:08 -0500
Subject: Re: [PATCH v3] dt-bindings: power: Convert bq27xxx dt to yaml
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
References: <20200512191451.1517-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9b3f5f13-7c58-d6b5-f0f2-777f2a8fad21@ti.com>
Date:   Tue, 12 May 2020 14:15:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512191451.1517-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All

On 5/12/20 2:14 PM, Dan Murphy wrote:
> Convert the bq27xxx.txt to yaml format

Please ignore this patch I send the wrong one

Dan
