Return-Path: <linux-pm+bounces-13259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135A966AFF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45F61F21AAF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269F1C1744;
	Fri, 30 Aug 2024 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HnY06aGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2019.outbound.protection.outlook.com [40.92.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BC1C1740;
	Fri, 30 Aug 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051132; cv=fail; b=XYf8eavFUZutE/S30zIn+gr/f8EJspHRRv2p14Ae9K2neBI3dNQo214I/lUgxjbvDPRQ0k4sFbPlSllnCcewx/P9BaoH6gdPvj3mu4lJjZjvospKjcwkkbhsDPVOFFap2yhoS0ggIYb+9NYmWXSewaGDz5W9cKfe1SZoQbn0uQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051132; c=relaxed/simple;
	bh=9PCyjkEOO8zI/aIC396LwHlIUr3tzgXmW4WNeP1ZZ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbj9IvRyfs2HcZExu16drFTFsSBhOMAgG/nWinZIjJz6lfG/hIx6tDyOHlALZVFyQrK1QuwtdnuA9xfbCdxAikdytMBYRhq8FTwCMMmyE4sIZzLQkg1AA/kKC85FKkE5LGfzRk0LhgMPK0NLAQLxuLxIgMI0B6EqaHZh0I3uXOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HnY06aGm; arc=fail smtp.client-ip=40.92.18.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot1wF/Xu9JMl5OJ4cycVxabQrvrSTc1sjpbh4DQdhGuyA1gMwQ+eyVEoitXR8wFg9IvyZAP6QyJwbjtwsMJZ/GdoqvrbXavapHlmvwDlY7hsu/qyVuPZcsprfaylg7DF3IvimRsfo0f0kpygGlvCSb0Ey57hwxEFw5lC3IUH0NAFX39vyBEwjG4+nP5RZLeeJMyENLkHXlTYd6yjpavyZwRQDgOHy27T01SlUAPcwhVgI/PcI8Lyb2u2IfGL/gOIAsErNxVP7W4fUHlqRh5CW6rZ2Nxy1017D8Tz67mwlH0S8YFmbI5+WOMbEz6ODYSzu+NXs/CDX1uD0fWWqwbmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1vQIwHIxB7rEiHQSFRfshvLqdoXg/wLUAtc0ELhEc8=;
 b=XODZhq7nGIJz25ugyJRK1zOx9YrXK8+QXDqTqQap9mGDPtFiL3GZyWab3e3Mo33hxk3EjWfVu0ft8Cj7pyI3HxOE1O+qoGRMPz4d57mCsaj3ClewaZVxpU4wCRbKmnI7PoHoH8uKaWqZwUFVGBr+JRAqsUySKD2v3avEoGyEtI+Jh3fIY82rP61MQjWBWcu7YE9ORKZwRQ40CHjPlgOtkF6obYBQdomPgbr6jnyqyCyU6Lz5oyCMvDOhKQGfu3b7LvRUA/jXulh0YEqS0k4KwmpX0tTiGjb5H6D0+ZUapEJ/UBuUkV8W9tMVCkkokqn38WSvPDTkSFms8ORBvUNiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1vQIwHIxB7rEiHQSFRfshvLqdoXg/wLUAtc0ELhEc8=;
 b=HnY06aGmEtNU2jS/qrOX4eNhx98YMgIFzFTNKIMV0A2eXP1JjI3fQix2jO0z9OBx7YfgRB8G+v8aNBOS1HhCIR6mpO1qAvIzZZGkt7qdYB3HUo1/7XFVbNpkBPBZ6CcxaEJ/mCyhWbEuyEoZTY+e2JeqJ9qqMCKm8IAyA5nQT4OQ6ztPXkmMvF1QTmboBas1m9vXOGUkQv4Utjh+IUvceYK2UyuAzal6xKcLvGPbYY+k2wOeJXrVqr7M7U4nqCZai3Ei54hHaN8MpgXeDRw7Ucm5zFnruM1kFiIetdi7/0BrKAHgOgdX7KzBeq4w/os7hbGLO68DzHtOx3iT2UT0xA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by PH7PR16MB4623.namprd16.prod.outlook.com (2603:10b6:510:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 20:52:08 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7918.020; Fri, 30 Aug 2024
 20:52:08 +0000
Date: Fri, 30 Aug 2024 15:52:04 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	broonie@kernel.org, lgirdwood@gmail.com, sre@kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	lee@kernel.org
Subject: Re: [RFC 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Message-ID:
 <MN2PR16MB2941EFA87151EF7685889EEAA5972@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240829213102.448047-1-macroalpha82@gmail.com>
 <20240829213102.448047-2-macroalpha82@gmail.com>
 <20240830163042.GA319200-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830163042.GA319200-robh@kernel.org>
X-TMN: [mRhboj51fY0Nh9vdhT+ZkqeM1JpeYNVv5XnbsFKyw9glBGfTfVDFS9UAPhXcgmUs]
X-ClientProxiedBy: SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::9) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZtIw9DyE0sVQgnNk@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|PH7PR16MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ca84f3-4fdf-4400-3e87-08dcc9359afb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|8022599003|15080799006|461199028|5072599009|19110799003|6090799003|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	NZXfK1IG0xk4EYnaQSJSBZeXtJr2fEc8uSI5sCVvnnQwUBs4xgQAfbSwkJ9E5PM3TBSVWeudXmUMeBrMTW9aY2rB259S1XzS0Zx/W2EeQXH1T4oNvQcLhkDsS2Xrw7phk/wz0SzNrQMvUJtiBnhZmSUZDzApF31trG9mk2HQR1CTf9amY9OHEdSRoIfaRzaNrll1LSnIYF0rKR9TxWjb/iwFXZXdS58OnPdDDgcfEE8ZC9q5qZstRYfivhYauhPIBhpbP9awgKMrD3139TUl0P4RHN2EjH+geRrkMSLMlTaepfr1yPrRKSuqVme14e6FuPu0ctlec/J4FFdbyElLCUkjLTD0F7qhViMP4Z1kY8u1myToBo+ffZuMOozqGr2gv9QWv5N4ELY/4Sypm7YVHLd0T2ra3Vn83IY9MqXv+j6CQjAIiXAVjdVd2LvKp9royrU47cfF0C9V0h7GeP83IRwjQ036faMTmdyalivEnLFjwMR1MyhuaXQ0N3aTvVqCliRt2oPyg0Rf9WIfO4JZF4z0ISl1r4jsZ8lNa4f/4VEN0oWbsyvOUktfdEjlCwHUv67t2TJHXctJqOe9QVjBEcK0A9EgHh5uu+GQo/8z5mHKzPXGN3NTOughAw1g7VTd4mQctawv3AtKXOTttyxEqfmSQp9Zgh3hGBVZYvH0dULJzXq+pyDpUHvMrFmgShWjFKGsyh+7orx2foIS5lqyg82aWHFjuv6IyWbNMLC8cFc6dN8OLq9FXVIgAQnNi/MWOYyIc8W4xuSubgwiaKfSo80y45p/hzcmfsW//hltfxv44V2u0xcyL4YyagOLOIx2OmZSDFhiYtZ2PqVVqJck01Lp2r/kqEXWjdUFDQ9kTZAT7Z3YkviyiVJYNidKZVx7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ajsAP9VPJ9hu3HL73+4mc4qwRC5ct/Bx7Dd7PNmQgnYYgB4s/pLUSlYuDsV?=
 =?us-ascii?Q?fGt9EHF8xQBpWRIa/J9bERM7MIg6VKKvAM18/2FT1a67ik1DFyNzwqb5XWHV?=
 =?us-ascii?Q?ttL6oXtTyEvxgCTd77ETJZHBv0CvAFbOMKXs+T82t1fOT3fWrOHIHPXROxRQ?=
 =?us-ascii?Q?RnBXQWuW/MZLJf3EltbP8I85jro6KCOLYnCecoXLuLt7xAwyKu97Vc8h5Yem?=
 =?us-ascii?Q?LMRUR1Z+EktbCS5dkkrp5uKqqRm+WkgJo9ijvD/vWwSXKeiE3CBLaaFmyEzA?=
 =?us-ascii?Q?nFk5W8f1TmcP82nExWRJS43DeVNrnJ/YVeiEF655bRiqskruikvVriW7Q6Z3?=
 =?us-ascii?Q?QWgO5wu+Mfv/STf8Ar7D3ibQUVNicwFCCz82+b6m2261k8AzV94HYY/qf2+w?=
 =?us-ascii?Q?z36VW1gJi4kA1LZKWmuFNPaMBoShcPHezD5YF77K+GWOIiwEhYP2yo4EuC/x?=
 =?us-ascii?Q?Ci8HbpPP7TKEkl7wTyGiIvqDdLuuTOftWg5rbmtt2C2KQ4OWyu4dC8r+lBGr?=
 =?us-ascii?Q?3PS3Em/qMxvAGQaR0vxwkfeT7R3BOAN+jCG8Qf+3JEDvMBAkJBE4nH2VapzV?=
 =?us-ascii?Q?mxS32Pn4LTuGjFL4qPBD/eea+CdXDNn/iQFHlqCOWJP51AegKO5HKKrNV/+J?=
 =?us-ascii?Q?t0fZblSvC5mHGweoqkJD5XUzd1NSHB6oDsMVx72AqUnScvaSnq/k3nwD9Kf0?=
 =?us-ascii?Q?IkNfUyFMDzdFYvRqilu8lrGCL5KOnuj1zpS851GtilSGrHKIDhLGu6zCW8sb?=
 =?us-ascii?Q?fWRPxWJft4IioWpAp4uZReK4T+Xqk/k0SEECS3wQqPmyRL6EJu6ttvLDuPxE?=
 =?us-ascii?Q?wwMk2LPMIF8teh0hkwajhKk4jxZkbUdqofPIVLpkFZuhPAo3i3eJgrj3qVxq?=
 =?us-ascii?Q?d4OJMdFWAWY4rBNOMdDXEqRdcDYKjxsPWxzGs1soog68PnAak8BUDEceDIrc?=
 =?us-ascii?Q?Wgf/r4oJzkPMNJ0OGXl21omt3ainU1yhciHi/F52kdEPBfYiVeuNgTn5EiMy?=
 =?us-ascii?Q?hT4fTwYQ/8i+rajfBolFjqkhDOsHlFG+45kTUEzfNnbHYxgyB+J4P76geNGY?=
 =?us-ascii?Q?N8CcuMwkmIZfWzw15DlEBwYDfG0Jp5wf3VIP28Cus3/UWV4SHGKgyZuoI79U?=
 =?us-ascii?Q?3EbwIaFsPI2QBixAjpKPv+ohjP9/J/VlkHpunIQ7cUgSnqOWT6MpL+UVGbI5?=
 =?us-ascii?Q?ZIkaDwytv+XnTF6nJNrRajHoBifePfYRNsFI30KLPBCeUVloYkLgXlq3vOiq?=
 =?us-ascii?Q?UaOz7r3mZ5kOVRf1xmtMFjXYs38qTTxpMAKfffQEdDl/aR0tRPowDLIckuiV?=
 =?us-ascii?Q?Q2eyqoT9UZ64vDphNTAl9n2s?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca84f3-4fdf-4400-3e87-08dcc9359afb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 20:52:08.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB4623

On Fri, Aug 30, 2024 at 11:30:42AM -0500, Rob Herring wrote:
> On Thu, Aug 29, 2024 at 04:30:58PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Document the Texas instruments BQ25703 series of charger managers/
> > buck/boost regulators.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 143 ++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > new file mode 100644
> > index 000000000000..e555aa60f9ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > @@ -0,0 +1,143 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: BQ25703 Charger Manager/Buck/Boost Converter
> 
> BQ25703A?

I'm not entirely sure on the nomenclature. I know for sure I have a
BQ25703A in my device, but I don't know if the A is important or not.
I'll just drop it until I know for sure to alleviate confusion.

> 
> > +
> > +maintainers:
> > +  - Chris Morgan <macromorgan@hotmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,bq25703a
> > +
> > +  reg:
> > +    const: 0x6b
> > +    description: I2C slave address
> 
> Drop description.

Acknowledged.

> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-supplies:
> > +    description:
> > +      phandle of the power supply that provides input power
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> Already has a type. You need a reference to power-supply.yaml at the 
> top level and 'maxItems: 1' here.

Gotcha, thank you.

> 
> > +
> > +  ti,charge-current:
> > +    description:
> > +      maximum current to apply to charging the battery
> > +    minimum: 0
> > +    maximum: 8128000
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> I guess this is copied from other TI parts, but really this should move 
> to a property with a unit suffix. Or these shared properties moved to a 
> shared schema so we aren't redefining the type multiple times.
> 
> Same for the others here.

Correct, I tried to reuse the same TI specific properties. I suppose I
could also eliminate ti,charge-current and ti,max-charge-voltage, and
then just require a phandle to a simple-battery node which contains
those two values in a vendor independent form. What do you think?

ti,current-limit and ti,minimum-system-voltage though are other
possible questions I have. Basically I could also create a vsys
regulator that represents the vsys coming off this device too (I
currently omit this entirely). This regulator wouldn't be programable
but would report the existing input current and input voltage for
the system, which in my case I'm pretty sure is stepped down to 5v
or less and then fed into an RK806 PMIC (I lack the schematics so
I don't know for sure). Of course if I did that then I'd have a
valid reason to add a "regulators" node since I'd have more than one
regulator.

> 
> > +
> > +  ti,current-limit:
> > +    description:
> > +      maximum total input current allowed
> > +    minimum: 50000
> > +    maximum: 6400000
> > +    default: 3250000
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  ti,max-charge-voltage:
> > +    description:
> > +      maximum voltage to apply to charging the battery
> > +    minimum: 1024000
> > +    maximum: 19200000
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  ti,minimum-sys-voltage:
> > +    description:
> > +      minimum system voltage while on battery power, with default value
> > +      depending based on cell configuration
> > +    minimum: 1024000
> > +    maximum: 16128000
> > +    default:
> > +      enum: [3584000, 6144000, 9216000, 16128000]
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  regulators:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      Boost converter regulator output of bq257xx
> 
> Doesn't this apply to "usb-otg-vbus"?
> 
> Really, only one regulator, so you don't need a container node.
> 

It does, that's a mistake on my part. And see above; I could add a
regulator for the vsys (even though you wouldn't be able to set the
voltage or current).

> > +
> > +    properties:
> > +      "usb-otg-vbus":
> 
> Don't need quotes.

Acknowledged.

> 
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-min-microamp:
> > +            minimum: 0
> > +            maximum: 6350000
> > +          regulator-max-microamp:
> > +            minimum: 0
> > +            maximum: 6350000
> > +          regulator-min-microvolt:
> > +            minimum: 4480000
> > +            maximum: 20800000
> > +          regulator-max-microvolt:
> > +            minimum: 4480000
> > +            maximum: 20800000
> > +          enable-gpios:
> > +            description:
> > +              The BQ25703 may require both a register write and a GPIO
> > +              toggle to enable the boost regulator.
> > +
> > +        additionalProperties: true
> 
> Nope.
> 

Acknowledged.

> > +
> > +        required:
> > +          - regulator-name
> > +          - regulator-min-microamp
> > +          - regulator-max-microamp
> > +          - regulator-min-microvolt
> > +          - regulator-max-microvolt
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-supplies
> > +  - ti,charge-current
> > +  - ti,current-limit
> > +  - ti,max-charge-voltage
> > +  - ti,minimum-sys-voltage
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/pinctrl/rockchip.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        bq25703: bq25703@6b {
> 
> charger@6b
> 

Acknowledged.

> > +            compatible = "ti,bq25703a";
> > +            reg = <0x6b>;
> > +            interrupt-parent = <&gpio0>;
> > +            interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
> > +            power-supplies = <&fusb302>;
> > +            ti,charge-current = <2500000>;
> > +            ti,current-limit = <5000000>;
> > +            ti,max-charge-voltage = <8750000>;
> > +            ti,minimum-sys-voltage = <7400000>;
> > +
> > +            regulators {
> > +                usb_otg_vbus: usb-otg-vbus {
> > +                    enable-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> > +                    regulator-max-microamp = <960000>;
> > +                    regulator-max-microvolt = <5088000>;
> > +                    regulator-min-microamp = <512000>;
> > +                    regulator-min-microvolt = <4992000>;
> > +                    regulator-name = "usb_otg_vbus";
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > -- 
> > 2.34.1
> > 

Thank you for your feedback,
Chris

