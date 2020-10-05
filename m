Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF29C283716
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJEN6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 09:58:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38839 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJEN6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 09:58:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so2845961ota.5;
        Mon, 05 Oct 2020 06:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LDinh5A/F+3x/5aBFTjkVAl5Osn8OcStGMlGEuBkhrI=;
        b=l5iwyeuRyB9D8vBDHkdU5QCHvZzw+CRsZVe7d9kq5pvZJDC+q3bgBpiFq499bO3/vN
         8LuhKQbtflTgqqBPgsDsz7Rid4gAG6KJ6yJwYCTZFqR6uCFOjPMIAfuufq1BASILMGQd
         hqqWE7sV2YDtZmnjbgGoZ7jMJa3DhFDYU0eYVYaYWaKhG5hso2yIUb1/wZLvyaPZnxlt
         tCmiTysC4nd4xant/fZfkusfsjF6SOOXuDIdIeD0Y+LLZENRn9jUhDY6zE4vtV+3/dWt
         /E/SZLCTfApv4VLonfojIiKzQ/hINQFz+Juzb9guCMTzU4DUyxrCvC45DpLOMLhlFoPS
         I1uw==
X-Gm-Message-State: AOAM532CK/Qt6yKptM3U8OWR+xoH/9MW3STHpjIjOLpKhTB0EqRjEAol
        rTvbBmw+cgN+iyxTyYYaeg==
X-Google-Smtp-Source: ABdhPJzTLpZWIBBWPALDH9jxT7TTMOQOXFRvepavcl5fhlDBEKDYp0A0x8+S7fx6Z2AavSBKCoJLCg==
X-Received: by 2002:a05:6830:1091:: with SMTP id y17mr3045674oto.160.1601906319138;
        Mon, 05 Oct 2020 06:58:39 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm2099386oie.26.2020.10.05.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:58:38 -0700 (PDT)
Received: (nullmailer pid 92014 invoked by uid 1000);
        Mon, 05 Oct 2020 13:58:37 -0000
Date:   Mon, 5 Oct 2020 08:58:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, daniel.lezcano@linaro.org,
        mka@chromium.org, robh+dt@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        rjw@rjwysocki.net, qperret@google.com, amitk@kernel.org,
        corbet@lwn.net, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
Message-ID: <20201005135837.GA91584@bogus>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <20201002114426.31277-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002114426.31277-4-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 02 Oct 2020 12:44:26 +0100, Lukasz Luba wrote:
> Update the documentation for the binding 'sustainable-power' and allow
> to provide values in an abstract scale. It is required when the cooling
> devices use an abstract scale for their power values.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

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
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a plain scalar
  in "<unicode string>", line 102, column 11
found a tab character that violates indentation
  in "<unicode string>", line 103, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/thermal/thermal-zones.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/thermal/thermal-zones.example.dts'
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/thermal/thermal-zones.yaml:  while scanning a plain scalar
  in "<unicode string>", line 102, column 11
found a tab character that violates indentation
  in "<unicode string>", line 103, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/thermal/thermal-zones.yaml
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1375670

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

