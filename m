Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C692C8A36
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 18:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgK3RAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 12:00:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42501 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgK3RAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 12:00:13 -0500
Received: by mail-io1-f66.google.com with SMTP id q137so8873448iod.9;
        Mon, 30 Nov 2020 08:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hq1MJpvbDh7bba2e04fPTBnORo/SbAhyQcObblCnObs=;
        b=e9nRknYpuq2gvfoe4HOKpeAZVgxHazGOwdFcyefos6U+sWdAlZcDHTwDLReNNOWGZ6
         63OEyMBYK4F6QDkSsPBBz2SNwHwIrbeacllRsfsolPY1C1177xfCs4EZjHzYDHdQmzb7
         1v/EyQBKdeXxRqmv/eoOQV+hnIsLQiWaVolCkIqcnQH4f1APhPP0thftpI+92KQT6fV3
         NSwM++S7oJ1fka5RMy+Vow4dqMr0wF+XfXwlTgGWL5D3YWWNLVP+BA69c1hZSk9isfk7
         ysaeGfHGSlO50qGY77GOVe880JwX/m4q4vXeNq+UGyV5L1w7FiCPLgAqmv3C9572koTa
         BmJg==
X-Gm-Message-State: AOAM532yaK3ix/uPji+Rt4DstH3KVGjghFVHQPfPDvatpjOBWzS0pRyo
        BrEjL928AqRSut0R7anAMw==
X-Google-Smtp-Source: ABdhPJzEFd02WNAYRRP4EaId0gS+QWu5Mv0Ty/p0+ar97FxggjqT8eC4thWRaa2uFkQA0ZhScIq8dg==
X-Received: by 2002:a6b:ea0d:: with SMTP id m13mr15605478ioc.148.1606755571994;
        Mon, 30 Nov 2020 08:59:31 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f2sm8214670iow.4.2020.11.30.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:59:31 -0800 (PST)
Received: (nullmailer pid 2625316 invoked by uid 1000);
        Mon, 30 Nov 2020 16:59:28 -0000
Date:   Mon, 30 Nov 2020 09:59:28 -0700
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 8/8] dt-bindings: thermal: tsens: Document ipq8064
 bindings
Message-ID: <20201130165928.GA2624688@robh.at.kernel.org>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
 <20201125174826.24462-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125174826.24462-9-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Nov 2020 18:48:25 +0100, Ansuel Smith wrote:
> Document the use of bindings used for msm8960 tsens based devices.
> msm8960 use the same gcc regs and is set as a child of the qcom gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 103 ++++++++++++++----
>  1 file changed, 79 insertions(+), 24 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:25:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:121:8: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:133:3: [error] syntax error: expected <block end>, but found '?' (syntax)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:134:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:140:3: [warning] wrong indentation: expected 4 but found 2 (indentation)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:141:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block collection
  in "<unicode string>", line 101, column 3
did not find expected '-' indicator
  in "<unicode string>", line 133, column 3
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts'
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1406385

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

