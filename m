Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9845338D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhKPOGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 09:06:08 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:37754 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhKPOFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 09:05:55 -0500
Received: by mail-oo1-f48.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so7260985oov.4;
        Tue, 16 Nov 2021 06:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tXv95hmRR4EUBmdVSIaH/WEAJNUBOE7cgJ4obwbjhws=;
        b=e2TvCGi+3qwGoUBV2kni7ZE48OZ+FwYb7mjC8xXKU3zG9noPqwuaIHuVhV/5dcSBI6
         2ZqI3s80nbVfVZnxOuo2ywgviSTKjyIS95oB1BinT7PrH1uGhL1xOi6NGC6qYaLuMbnS
         tEdY/oMQeBzH/z/3+j/c4tw6O1IiJegbzm8Q4t7MIzCbcLSul9hFk9nN1wmfYEfsw5jX
         FAJN019nueBlqCGrDx3VxYeKvJD9Uqx4smNk3ex5665vu2mOAkmkv8S3zmfpXsyXUxjx
         4qO+UGNynwmtUh+skau84d4DHyFLzNaNx6WcXaYIuszbjrKXXyZdwQcqaWSAOH/IYcqh
         0SiQ==
X-Gm-Message-State: AOAM5337KHMUOxjS3rwcOOBlilFV9EtpUO8RFEB7s/7+Qr01jrAFGYyT
        ETEMNpk4tFyazeBLo5kf0g==
X-Google-Smtp-Source: ABdhPJzfMw+hfGpmUhLkk4O45NLH8ApWsOcO2NVDfpy6q7iWxaMZQ08hgwyt9yMGglTzcxnGmw50Ag==
X-Received: by 2002:a4a:e701:: with SMTP id y1mr3946244oou.42.1637071378020;
        Tue, 16 Nov 2021 06:02:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q6sm3859343oig.14.2021.11.16.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:02:57 -0800 (PST)
Received: (nullmailer pid 3444647 invoked by uid 1000);
        Tue, 16 Nov 2021 14:02:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, fan.chen@mediatek.com,
        linux-power@fi.rohmeurope.com,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rostokus@gmail.com
In-Reply-To: <740503b6b6439e01959016223f1ae464e82824c3.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com> <740503b6b6439e01959016223f1ae464e82824c3.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 1/9] dt-bindings: battery: Add temperature-capacity degradation table
Date:   Tue, 16 Nov 2021 08:02:53 -0600
Message-Id: <1637071373.522185.3444646.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 16 Nov 2021 14:24:48 +0200, Matti Vaittinen wrote:
> Some charger/battery vendors describe the temperature impact to
> battery capacity by providing tables with capacity change at
> given temperature. Support providing this temperature - capacity
> dependency using the simple-battery DT nodes.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../bindings/power/supply/battery.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/supply/battery.yaml:134:36: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/power/supply/battery.yaml:  while parsing a block mapping
  in "<unicode string>", line 134, column 11
did not find expected key
  in "<unicode string>", line 134, column 36
make[1]: *** Deleting file 'Documentation/devicetree/bindings/power/supply/battery.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 850, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block mapping
  in "<unicode string>", line 134, column 11
did not find expected key
  in "<unicode string>", line 134, column 36
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/power/supply/battery.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/battery.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/power/supply/battery.yaml
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1555776

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

