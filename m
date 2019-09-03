Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63259A69DB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfICN3e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 09:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfICN3d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 09:29:33 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498CA23402;
        Tue,  3 Sep 2019 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567517372;
        bh=NLqCL4CDXLU3XgXKCj95PxujHWeCjp562H7YUcMntWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qaXN86v6cIyTWdnvtaZOQQfBuuLThLlMRA/EJyQNgmyoLCjT/75zE/M4mRQeArqAE
         q4YgAkDS6yIyQVA1WxKIVB7rtdCigj9Sz0V6NzXh5PlLXZooECitbVO6sWthzskktB
         K+ItPCsbY4BLi25J8cwa71OUpyPJxZShfeyXk83Q=
Received: by mail-lf1-f44.google.com with SMTP id r134so12000449lff.12;
        Tue, 03 Sep 2019 06:29:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXceZ1F0VtCGnv9s3brmXuw2bEDDN7WCQ0LhshmWuK9GoK3nIy0
        07jSwK7TNhywRrFEtPhPHXfCyUK6Y2dMkQXBWdw=
X-Google-Smtp-Source: APXvYqxqbuDcNwZVBZKdEn/yqco/nPvJHxybzLgeR8t1/wyDoTImujg8oF2KZNPIWeHPuUNFUp5BwgTKED9vOoaznqs=
X-Received: by 2002:ac2:41c2:: with SMTP id d2mr6978921lfi.24.1567517370489;
 Tue, 03 Sep 2019 06:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190902150336.3600-1-krzk@kernel.org> <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
 <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
 <CAL_JsqJUfGBRAv=StPyavQU1DiHnFwUseNCvP6Ce_ZMohJXTXQ@mail.gmail.com>
 <CAJKOXPcjF9nERQxDdSVBLsfc2V_M1_BPZ6iM6EXvEx4tdr3rDQ@mail.gmail.com> <CAL_Jsq+1NEcmvrKPp9N=07CbxT3ZUsViXk7GGb1v0NzsxvWEdg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1NEcmvrKPp9N=07CbxT3ZUsViXk7GGb1v0NzsxvWEdg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Sep 2019 15:29:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcGWuW7HP-_kj_OjpPyHtj9gr36bpVUeT5VF2V9wTZY9Q@mail.gmail.com>
Message-ID: <CAJKOXPcGWuW7HP-_kj_OjpPyHtj9gr36bpVUeT5VF2V9wTZY9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: syscon-reboot: Convert bindings
 to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Sep 2019 at 15:12, Rob Herring <robh+dt@kernel.org> wrote:
> > arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: syscon-reboot:
> > {'regmap': [[9]], 'mask': [[1]], '$nodename': ['syscon-reboot'],
> > 'value': [[1]], 'offset': [[1024]], 'compatible': ['syscon-reboot']}
> > is valid under each of {'required': ['mask']}, {'required': ['value',
> > 'mask']}, {'required': ['value']}
>
> Ahh, right. 'anyOf' is what we want:
>
> anyOf:
>   - required: [ value ]
>   - required: [ mask ]

This triggers meta-schema error:

  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
Traceback (most recent call last):
  File "/home/kozik/.local/lib/python3.5/site-packages/dtschema/lib.py",
line 429, in process_schema
    DTValidator.check_schema(schema)
  File "/home/kozik/.local/lib/python3.5/site-packages/dtschema/lib.py",
line 575, in check_schema
    raise jsonschema.SchemaError.create_from(error)
jsonschema.exceptions.SchemaError: Additional properties are not
allowed ('anyOf' was unexpected)

Failed validating 'additionalProperties' in metaschema['allOf'][0]:
    {'$id': 'http://devicetree.org/meta-schemas/base.yaml#',
     '$schema': 'http://json-schema.org/draft-07/schema#',
     'additionalProperties': False,
     'allOf': [{'$ref': 'http://json-schema.org/draft-07/schema#'}],
     'description': 'Metaschema for devicetree binding documentation',
     'properties': {'$id': {'pattern':
'http://devicetree.org/schemas/.*\\.yaml#'},
                    '$schema': {'enum':
['http://devicetree.org/meta-schemas/core.yaml#',

'http://devicetree.org/meta-schemas/base.yaml#']},
                    'additionalProperties': {'type': 'boolean'},
                    'allOf': {'items': {'propertyNames': {'enum': ['$ref',
                                                                   'if',
                                                                   'then',
                                                                   'else']}}},
                    'definitions': True,
                    'dependencies': True,
                    'description': True,
                    'else': True,
                    'examples': {'items': {'type': 'string'},
                                 'type': 'array'},
                    'if': True,
                    'maintainers': {'items': {'format': 'email',
                                              'type': 'string'},
                                    'type': 'array'},
                    'oneOf': True,
                    'patternProperties': True,
                    'properties': True,
                    'required': True,
                    'select': {'allOf': [{'$ref':
'http://json-schema.org/draft-07/schema#'},
                                         {'oneOf': [{'properties':
{'properties': True,

'required': True},
                                                     'type': 'object'},
                                                    {'type': 'boolean'}]}]},
                    'then': True,
                    'title': {'maxLength': 100},
                    'unevaluatedProperties': {'type': 'boolean'}},
     'required': ['$id', '$schema', 'title', 'maintainers']}

Best regards,
Krzysztof
