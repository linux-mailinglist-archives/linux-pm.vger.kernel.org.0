Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22F43B194
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 13:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhJZLzt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 07:55:49 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58546 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233909AbhJZLzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 07:55:48 -0400
Received: from [79.2.93.196] (port=34480 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mfL19-004tyV-LQ; Tue, 26 Oct 2021 13:53:23 +0200
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: add Maxim MAX77976
 battery charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211004130732.950512-1-luca@lucaceresoli.net>
 <20211006161548.ary3mijxlcz6mdob@earth.universe>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <fdc20f96-c407-b0e9-365d-264655a74844@lucaceresoli.net>
Date:   Tue, 26 Oct 2021 13:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006161548.ary3mijxlcz6mdob@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 06/10/21 18:15, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 04, 2021 at 03:07:31PM +0200, Luca Ceresoli wrote:
>> Add bindings for the Maxim MAX77976 I2C-controlled battery charger.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  .../bindings/power/supply/maxim,max77976.yaml | 41 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 +++
>>  2 files changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
>> new file mode 100644
>> index 000000000000..b508d9cc04a0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77976.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim Integrated MAX77976 Battery charger
>> +
>> +maintainers:
>> +  - Luca Ceresoli <luca@lucaceresoli.net>
>> +
>> +description: |
>> +  The Maxim MAX77976 is a 19Vin / 5.5A, 1-Cell Li+ battery charger
>> +  configured via I2C.
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max77976
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
> 
> Add
> 
> allOf:
>   - $ref: power-supply.yaml#
> 
> and replace additionalProperties with unevaluatedProperties, so that
> the power-supplies property is also valid.

OK, will fix.

-- 
Luca
