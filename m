Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D3283C2E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgJEQPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 12:15:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbgJEQPD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Oct 2020 12:15:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6756911D4;
        Mon,  5 Oct 2020 09:15:02 -0700 (PDT)
Received: from [10.57.49.124] (unknown [10.57.49.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8A63F66B;
        Mon,  5 Oct 2020 09:14:58 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, daniel.lezcano@linaro.org,
        mka@chromium.org, robh+dt@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        rjw@rjwysocki.net, qperret@google.com, amitk@kernel.org,
        corbet@lwn.net, Dietmar.Eggemann@arm.com
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <20201002114426.31277-4-lukasz.luba@arm.com> <20201005135837.GA91584@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e27273cc-81d7-65fb-b99a-ecebc3efe74c@arm.com>
Date:   Mon, 5 Oct 2020 17:14:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201005135837.GA91584@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 10/5/20 2:58 PM, Rob Herring wrote:
> On Fri, 02 Oct 2020 12:44:26 +0100, Lukasz Luba wrote:
>> Update the documentation for the binding 'sustainable-power' and allow
>> to provide values in an abstract scale. It is required when the cooling
>> devices use an abstract scale for their power values.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-extract-example", line 45, in <module>
>      binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>    File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
>      return constructor.get_single_data()
>    File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
>      node = self.composer.get_single_node()
>    File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
>    File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
> ruamel.yaml.scanner.ScannerError: while scanning a plain scalar
>    in "<unicode string>", line 102, column 11
> found a tab character that violates indentation
>    in "<unicode string>", line 103, column 1
> make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/thermal/thermal-zones.example.dts] Error 1
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/thermal/thermal-zones.example.dts'
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/thermal/thermal-zones.yaml:  while scanning a plain scalar
>    in "<unicode string>", line 102, column 11
> found a tab character that violates indentation
>    in "<unicode string>", line 103, column 1
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> make: *** [Makefile:1366: dt_binding_check] Error 2
> 
> 
> See https://patchwork.ozlabs.org/patch/1375670
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

My apologies, I have put tabs instead of spaces in there.
I have run this command and now it passed.

I will resend the patch 3/3.

Regards,
Lukasz
