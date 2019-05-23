Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310EA28205
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfEWP6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 11:58:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46317 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbfEWP6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 11:58:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26so4769401lfh.13
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2019 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=814odXxcuVfRati0gurkRFNz500nIRSYGE0iZM3L0Ng=;
        b=Ageej1MS07LK+EGbOwJeeZnHugvJ2fp8glfAPww4ixElzxf7Mr9k2u3Mrabn3FHQUH
         6SO7ORaAoUQeMS/Ib6Jl+nwx3QQAX0PLJpWHFwC/5HtQRVID9SLQlvX7gW7ilcysorAR
         A+cR1aXqoTu1wpK+PtW6Ijizg+zeJiF6Oc3y9NKLtVw2t4RFENGr5XhLiidgTWI2kqjs
         PIPdiyY4xg9HDeqVu1M6xogSrHQPgl5Y7RjoiNsU6Lem3maqXBls43ZlALdMseQC0soh
         qT86xHUKoGeN1JHZryZcT3CdO7vl+5N9A0Ym+LwtzsGFDst88ctcyGNcvFIDB7+5tCKe
         oRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=814odXxcuVfRati0gurkRFNz500nIRSYGE0iZM3L0Ng=;
        b=cuCFD1f5mY5ZxVtiQhO7eS7sh7GyWLEIaGAp7qLw2Y43ntM0BY+U6a6TWjc2P+jSWx
         SP9k4mCplUjzL4Alr/v2bgMmM/WMXKN1o9Ox0aaF/CQB8Bq+ErI+N5rX8jvlAgHPdHQh
         2xGxz0317y672X7KyxnrQynfwIBruDyTyQNZrmTl4ouIZetFlrggiEz6cuem8MddZWqL
         HF5tZz4ftoZ3HKDk0ywSj2fA6RENKcmjk8Yv4LrmGYjaQ7oTGILVtkFzuLl0wFdqHpZy
         EAZwcgWRnNSSeM7q6guGZk0YIJPBgdAaeijTkJQNvEXm7C6SZiOy3wpb8UvLGLSvrHkK
         YI7w==
X-Gm-Message-State: APjAAAXHIB6TxT5LETvbnOdszYStYJYEk5vXW7EBBrcUGo8B5MIjxzgr
        VchVa611LSnzZ61d8FOZCPMJIA==
X-Google-Smtp-Source: APXvYqymlMgaC20dZjIqJXcTZKOZ7c3DdFnP/su1Uisd7tkxD46l7+ihMKv9WheB40KSvyOITAnCzQ==
X-Received: by 2002:ac2:4286:: with SMTP id m6mr6324069lfh.150.1558627131672;
        Thu, 23 May 2019 08:58:51 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r27sm385711lfp.73.2019.05.23.08.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:58:51 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] dt-bindings: interconnect: qcs404: Introduce
 qcom,qos DT property
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
 <20190415104357.5305-5-georgi.djakov@linaro.org>
 <20190418225150.GN27005@builder>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <a507a79e-e4da-4129-f52b-8db9927dc2a4@linaro.org>
Date:   Thu, 23 May 2019 18:58:47 +0300
MIME-Version: 1.0
In-Reply-To: <20190418225150.GN27005@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn and Rob,

On 4/19/19 01:51, Bjorn Andersson wrote:
> On Mon 15 Apr 03:43 PDT 2019, Georgi Djakov wrote:
> 
>> There are separate hardware blocks per each interconnect that allow QoS
>> configuration to be applied to each port (node). There are different kinds of
>> priorities that could be set on these ports. Each port supports also various
>> QoS modes such as "fixed", "limiter", "bypass" and "regulator". Depending on
>> the mode, there are a few additional knobs that could be configured.
>>
>> Introduce the qcom,qos property, so that we describe this relation in DT and
>> allow the interconnect provider drivers can make use of it.
>>
> 
> As the example shows we will end up with two nodes describing the same
> hardware with pretty much identical set of properties.

I am still split and hesitant about what would be the best way to represent this
in DT and it would be nice to reach some conclusion.

So the idea is that the QoS driver could be a standalone driver that does some
static QoS configuration. The clocks i have listed in the example below are not
the same, sorry. We should list there some of the interface clocks that need to
be enabled before configuring the port priorities instead. For example USB or
UFS axi clock and not the NoC clocks.

This makes the DT properties of the two nodes different. Оn one side we collect
bandwidth requests and send them to the remote processor (RPM) and each NoC is
represented in DT as child of RPM (like the rpm controlled regulators and
clocks). On the other side we also have the mmio registers for configuring port
priorities that may fit in DT under soc {} with their mmio registers and a list
of iface clocks.

> I really do think it's better to represent and implement the NoC
> controllers on the mmio/platform bus and have a small "proxy" as a child
> of the RPM.
>
> By doing this you avoid the duplication of the clock properties and you
> don't need the qcom,qos reference to pair up each "bus performance
> driver" to the "bus qos driver".

The clock properties would contain different set of clocks - NoC clocks for the
DT nodes in rpm {} and the iface clocks for the QoS DT nodes in soc {}.

> And you still maintain the idea that the entity you request bandwidth
> votes with are the NoC controller (which also will be the QoS
> controller).

I assume that the entities are the NoC controllers that we talk to through the RPM.

Thanks,
Georgi

> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>
>> v2:
>> - New patch.
>>
>>  .../bindings/interconnect/qcom,qcs404.txt     | 31 +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>> index 9befcd14a5b5..b971e0ee2963 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>> @@ -11,9 +11,37 @@ Required properties :
>>  Optional properties :
>>  clocks : list of phandles and specifiers to all interconnect bus clocks
>>  clock-names : clock names should include both "bus_clk" and "bus_a_clk"
>> +qcom,qos : phandle to the QoS device-tree node
>>  
>>  Example:
>>  
>> +soc {
>> +	...
>> +	bimc_qos: interconnect@400000 {
>> +		compatible = "qcom,qcs404-bimc-qos";
>> +		reg = <0x400000 0x80000>;
>> +		clock-names = "bus_clk", "bus_a_clk";
>> +		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>> +			<&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +	};
>> +
>> +	pcnoc_qos: interconnect@500000 {
>> +		compatible = "qcom,qcs404-pcnoc-qos";
>> +		reg = <0x500000 0x15080>;
>> +		clock-names = "bus_clk", "bus_a_clk";
>> +		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
>> +			<&rpmcc RPM_SMD_PNOC_A_CLK>;
>> +	};
>> +
>> +	snoc_qos: interconnect@580000 {
>> +		compatible = "qcom,qcs404-snoc-qos";
>> +		reg = <0x580000 0x14000>;
>> +		clock-names = "bus_clk", "bus_a_clk";
>> +		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>> +			<&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +	};
>> +};
>> +
>>  rpm-glink {
>>  	...
>>  	rpm_requests: glink-channel {
>> @@ -24,6 +52,7 @@ rpm-glink {
>>  			clock-names = "bus_clk", "bus_a_clk";
>>  			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>>  				<&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +			qcom,qos = <&bimc_qos>;
>>  		};
>>  
>>  		pnoc: interconnect@1 {
>> @@ -32,6 +61,7 @@ rpm-glink {
>>  			clock-names = "bus_clk", "bus_a_clk";
>>  			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
>>  				<&rpmcc RPM_SMD_PNOC_A_CLK>;
>> +			qcom,qos = <&pcnoc_qos>;
>>  		};
>>  
>>  		snoc: interconnect@2 {
>> @@ -40,6 +70,7 @@ rpm-glink {
>>  			clock-names = "bus_clk", "bus_a_clk";
>>  			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>>  				<&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +			qcom,qos = <&snoc_qos>;
>>  		};
>>  	};
>>  };
