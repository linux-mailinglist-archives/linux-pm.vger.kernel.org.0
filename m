Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E966B2C8CA6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgK3SYE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 13:24:04 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:44685 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgK3SYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 13:24:04 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2858E40266;
        Mon, 30 Nov 2020 19:23:21 +0100 (CET)
Subject: Re: [PATCH 11/13] dt-bindings: cpufreq: Convert qcom-cpufreq-hw to
 YAML binding
To:     Rob Herring <robh@kernel.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        nks@flawful.org, lgirdwood@gmail.com, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        phone-devel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-12-angelogioacchino.delregno@somainline.org>
 <20201130172305.GA2661895@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <9fc67c3f-4753-fe4f-ca1b-7faeee2abe7d@somainline.org>
Date:   Mon, 30 Nov 2020 19:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130172305.GA2661895@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 30/11/20 18:23, Rob Herring ha scritto:
> On Thu, 26 Nov 2020 19:45:57 +0100, AngeloGioacchino Del Regno wrote:
>> Convert the qcom-cpufreq-hw documentation to YAML binding as
>> qcom,cpufreq-hw.yaml.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 173 +---------------
>>   .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 196 ++++++++++++++++++
>>   2 files changed, 197 insertions(+), 172 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: properties:clock-names: [{'const': 'xo'}, {'const': 'ref'}] is not of type 'object', 'boolean'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: maintainers:0: 'TBD' is not a 'email'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: ignoring, error in schema: properties: clock-names
> warning: no schema found in file: ./Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> Error: Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.example.dts:150.3-151.1 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1364: dt_binding_check] Error 2
> 
> 
> See https://patchwork.ozlabs.org/patch/1406857
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Hello!
All the errors that you've pointed out have been fixed on both the CPR,
CPR3 and cpufreq-hw, but before pushing a V2 of this patch series...

Well, I have a question: the qcom-cpufreq-hw driver has no MAINTAINERS
entry and there was no maintainer for this driver specified in the old
txt format binding.

What should I write in the "maintainers" field of the YAML binding for
this driver?
Should I assign it to the subsystem maintainer?

Thanks,
- Angelo
