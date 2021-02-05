Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83DE31019C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhBEA14 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 19:27:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36556 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhBEA14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 19:27:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1150QvK5061256;
        Thu, 4 Feb 2021 18:26:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612484817;
        bh=yq7hCIHhoSTeDHW7juAsUUz79Y6SVLIYjBY085/BArw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bRbldSr45AFTDWj5sJu0z7AZJMA0QmQM09LruICalcxcxkCxIiJmJiFISYns/c1TU
         3ZWpU6wTjGzXqvPAhXUCoT3gYSahDuu76kyRpxpjukRC2LKMPdKDfhZV2rh4z8YDdo
         qElbrEdoI4ycFS0rHZF8gHZoKfZTPoXlJHSYGWac=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1150QvX2129581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Feb 2021 18:26:57 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Feb
 2021 18:26:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Feb 2021 18:26:56 -0600
Received: from [10.250.39.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1150QuOY077490;
        Thu, 4 Feb 2021 18:26:56 -0600
Subject: Re: [PATCH V3 1/2] dt-bindings: power: bq27xxx: add bq78z10
To:     Rob Herring <robh@kernel.org>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sre@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <grygorii.tertychnyi@leica-geosystems.com>,
        <andrey.zhizhikin@leica-geosystems.com>, <krzk@kernel.org>,
        <pali@kernel.org>
References: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210203104100.17143-2-Qing-wu.Li@leica-geosystems.com.cn>
 <20210204233721.GA1331253@robh.at.kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <3342dd48-e165-2ca4-6411-d2641163ff91@ti.com>
Date:   Thu, 4 Feb 2021 18:26:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204233721.GA1331253@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Li

On 2/4/21 5:37 PM, Rob Herring wrote:
> On Wed, 03 Feb 2021 10:40:59 +0000, LI Qingwu wrote:
>> Add bindings for TI BQ78Z100. An I2C interface gas gauge.
>> It provides a fully integrated safety protection
>> and authentication for 1 to 2-series cell Li-Ion and
>> Li-Polymer battery packs.

$subject has the wrong part number

Dan


>> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
>> ---
>>   Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
> Acked-by: Rob Herring <robh@kernel.org>
