Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD9299089
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783175AbgJZPIQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 11:08:16 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:57249
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbgJZPIQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 11:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OKkxEpxt/qeh6+XEjBQjWyaf++Sdxip/WLp0gg7VsQ=;
 b=nerHGGUDj7ZJ8HbFKaVhIVSSl3L/y53NmPiYSim/1motS4csLIsVfs3TxYwGnWLZ2nMhChVHzz1M7HU8sccrsa1IBdYtlSk2ucTuRqdHbJVfCbIAT4U/9Ihol/wRXFdsRKERw6KW1FeDMIYnCXHCVPP7u/0y48aip87u0vlQ7ZA=
Received: from AM5PR1001CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::34) by AM0PR04MB6178.eurprd04.prod.outlook.com
 (2603:10a6:208:146::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 15:08:09 +0000
Received: from HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:15:cafe::65) by AM5PR1001CA0057.outlook.office365.com
 (2603:10a6:206:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 15:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT014.mail.protection.outlook.com (10.152.0.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 15:08:09 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.52) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 26 Oct 2020 15:08:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJfdrLG/VYPncwveLrnRILzpBK3PtbiHrVCzpuaOsKcC3G3iWQnw/Mf99acb+qR86wPSwadllTKlZZhG9erEfagvnnCWbn+F4etDcdnt7d8VLHI2h3Lr3Fxl+5EXCnho3jbkX+lBBu4CLzGzAGby/MPVV0nw7oFY11KxF4ECweGrM204bJkaP8GmT2Tsgs6zuY1dR3/0TL12HtLtsZDTt9UGPsQjkIWbDyDgeGGkk3NpRJujgd8MPBnV2t2G2LUctrsoorr6q2pz/794p7LvymtythN1HvcZPmXMFwAhP3gV81fSSQu721jBHASp6WJBxtMcBCCHLoEdaNJInKGPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baw2LL+5ts3qmOLl4MdTrKvR2w3ddwrncl8XUx3hD3U=;
 b=gEcSgXchmiNPk1ddVWE1eUU4qoOVZt1+tdEondq6WP/SSkWujpYE4HcJvIHbX/7ZuYvfVPQMreT42bAo0AlV+vjDzI5jpi+0kiBVc1Cwpn0CTZAWIRB0w2McouUxDPEQUN/dI+4MreyIwseXw3JoJSRY8N300twjDyEja80IkX+U8pzssOwB9IpvWCPP6Hjgp96kLiJtnZusgvb1AsGYFYsf7B50s4qJ/L33xd3U4Oe1sU0wPVZdXRPu3ovvgD9l/hw+Vzu8cgPFW006Ey0lcXmEGp4py786NL55RIuo/+U3Jl/ejiqPMmeO6/NALVCUU1lUV4zTjiqt9RgqWAb9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB7PR04MB5097.eurprd04.prod.outlook.com (2603:10a6:10:15::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 15:08:04 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::35e9:2f0b:112b:28c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::35e9:2f0b:112b:28c3%6]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 15:08:04 +0000
Subject: Re: [PATCH] dt-bindings: power/supply: Add ltc4162-l-charger
To:     Rob Herring <robh@kernel.org>
CC:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201021141030.27751-1-mike.looijmans@topic.nl>
 <20201026144331.GA123160@bogus>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dc7cfc2e-6cf2-4369-b27f-f3a949d4638b@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.a8ff2286-c81b-46a6-ad61-108358632253@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <5fd054f4-cb7b-7b2f-4827-a8171b6d54d1@topic.nl>
Date:   Mon, 26 Oct 2020 16:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201026144331.GA123160@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [81.173.50.109]
X-ClientProxiedBy: AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29)
 To DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.80.3] (81.173.50.109) by AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 26 Oct 2020 15:08:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7d65512-6aca-4d2d-ce0a-08d879c0f318
X-MS-TrafficTypeDiagnostic: DB7PR04MB5097:|AM0PR04MB6178:
X-Microsoft-Antispam-PRVS: <AM0PR04MB61782FFBF7667B877363140D96190@AM0PR04MB6178.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PeWCwlPKnipdbBjFU2P0CWvl95yVTFHF8pWncJM5GTLlx1dDaiPP7HBSQF8ld9c7YCcLbXzx3MPpmRBdCQ21gg+XkKOEqIQ2VANSRGoRWXn6xtgaXRpxK0npsJUtr03iNKV3S9C09T4Um2SkK6POhiS6W6lN5is/FfufJnpdP7tdTi99ef5WvGgXNb9OP2Ukgl9gtPHSGawKFhwoXH1x4j7mgfYY9G31u+y2FVK0CHb0fNlEwx4OZskQFx2cYPNC6Gg3BwIHHBTKykGedJcAvBx3QFVd60c5KtZ0fI+8fEIeCQDv55enJ64hNqCb8i8Fa1uEcz4hi8XkPuCcnSCSLBWGE5xPYI/gLrDDFMluYPewyKaVoyM6cHTWfWAwLNMnwlglFdsIUS2kJqfcapEJWKs3jQNHU0K2wFZO/feAy6epTvsJMDRT3fgOiJTXHkQPh01MrbfNgccvEPh7b2hDJA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39840400004)(346002)(42882007)(66574015)(4326008)(36916002)(316002)(52116002)(66946007)(31696002)(6486002)(66556008)(66476007)(16576012)(44832011)(2906002)(36756003)(8936002)(186003)(16526019)(956004)(966005)(26005)(6916009)(83380400001)(478600001)(31686004)(5660300002)(8676002)(2616005)(83170400001)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2dReQEPFfpe3rtCYm1xY6aO447duQ4Q5yIUI8hwn3cquZd2h9PIrbvd2sP+USmpJkqli3/rWDEY99Kml3VukBOpb+92Zk1fid3mo31mGeQqnCWJoUGT9GfNmsFK40VD5PlWEwujSnTURi9ttqYmNpB57wFCFXjHPMyTLP17rmWwdVTctAC/kXiutRO5kZeqYx6wzdgkI2xYOtEh7W0egs95GB7AdP0umMjVH2x1x2WzPunxXCQND8YmffcaKHH4aCReUQgp08HQ2NMfU1FzR3kPRh8z/eqGaZIPFqmzyvihpA7fhETb3TU++la3NVLa179I3uNNkTrHkNfW4SXEISwAIFZRG6/uJugf48rHoKu0XuhvpTN5Fr6C52l22S/cNJX71wasvAIPbVzi/wc7Xa7jQgpsLhgYWVizpdYGniMDXMdTv3+J540z8r1TTgSJ3thTR42HqezDUSjR+O3KbBeMjpsXsNlm3t17nqFD9ImVot2zD3/atmcyfj63dTaP55ayd1qIUQXXJCoWZizqq0yBYD/jEkzKFDKz7fJUjleKRTMwSeH5l1mq50BmZUmWEq4qEqBRObLYY+1UEE59AEvqnvckzRk6VfxHl/UAT7zFNf7phOMuHVgyihvL8mzgURIf40nTLIHuAu64Pv6YWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5097
X-CodeTwo-MessageID: 1c5cc6bd-07a5-4c66-93ab-c78e66920e39.20201026150806@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d9353d4e-473f-423e-a2a2-08d879c0efe6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK4zp6y8wxXKdCHuIE6Ti1dUd0RLH6qE7+mLC/J/dT0dJjfUtaYJN4g0Y1XTdNQFpH+M4UlLAo0twrOCReoIuCGN1kcwxfkvWkeLLGnj86jgOI2PkJp7qm2vEK7C20G9jpK4tQ9YzeB+2d3wO85LFXAHotevoIpbhB1NsN0PogYJjZF9VBABvQJsGKodXlSqW1kymuT3wwpvggbZduR0c64XH1rVce+3j/OhwYiZ6sslYMtoAcK2oD+OazaSu8WgPJBzEi5e0O7vl7wsVopcoRRorDVB7qEGiqYQAVsD0nW8PIm+vyItCTT9ZiJN7ddHmw924rPoH30RlWN+tnBfAy+4a1O2geoiMo4ojymj8tkDTW411LoyugquT3bd6u2X3s7VHnNBxOqn9bnTEXK/GLaO5iXOWP6/zn0lT3bXZYql3yrKISkQ5kP082kmK/xcEs+FZ+UEXWkhfSjvs/1QR5WSTxJWpcjQ1RtxdLqIf19P7PNTl8OTAr3S4KbDdIkf
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(346002)(39840400004)(396003)(376002)(136003)(46966005)(7636003)(7596003)(26005)(186003)(15974865002)(83380400001)(70586007)(5660300002)(36916002)(8936002)(478600001)(82310400003)(16526019)(966005)(8676002)(6486002)(70206006)(53546011)(6916009)(2906002)(47076004)(83170400001)(16576012)(2616005)(31686004)(36756003)(44832011)(956004)(336012)(356005)(31696002)(4326008)(66574015)(42882007)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 15:08:09.0496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d65512-6aca-4d2d-ce0a-08d879c0f318
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6178
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 26-10-2020 15:43, Rob Herring wrote:
> On Wed, Oct 21, 2020 at 04:10:30PM +0200, Mike Looijmans wrote:
>> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
>> reading back telemetry and to set some charging options like the input
>> current limit.
>>
>> This adds the devicetree bindings.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   .../bindings/power/supply/ltc4162-l.yaml      | 60 +++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4=
162-l.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.ya=
ml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
>> new file mode 100644
>> index 000000000000..a23dd6f3fae0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2020 Topic Embedded Products
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/power/supply/ltc4162-l.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Linear Technology (Analog Devices) LTC4162-L Charger
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +description: |
>> +  The LTC =C2=AE 4162-L is an advanced monolithic synchronous step-down=
 switching
>> +  battery charger and PowerPath (TM) manager that seamlessly manages po=
wer
>> +  distribution between input sources such as wall adapters, backplanes,=
 solar
>> +  panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
>> +
>> +  Specifications about the charger can be found at:
>> +    https://www.analog.com/en/products/ltc4162-s.html
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - lltc,ltc4162-l
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: I2C address of the charger.
>> +
>> +  lltc,rsnsb:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Battery sense resistor in milli Ohm.
>> +    minimum: 1
>> +
>> +  lltc,rsnsi:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Input current sense resistor in milli Ohm.
>> +    minimum: 1
> These should have a unit suffix as defined in property-units.txt.
> There's not one for milli Ohms, does micro Ohms give you enough range?
> If not, you can add it though that's discouraged simply so that we don't
> have differring units in each binding for the same thing.

Micro Ohms is fine, might even be beneficial. Expected values are in the=20
10 milliohm range. Sorry to have missed that. I'll adapt the driver to=20
use this value without overflowing.



--=20
Mike Looijmans

