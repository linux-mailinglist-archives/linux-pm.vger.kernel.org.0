Return-Path: <linux-pm+bounces-12055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12BF94D61B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 20:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E4C1C21665
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FC3146D75;
	Fri,  9 Aug 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="wQaphls2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="pIciiQgJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A213D523;
	Fri,  9 Aug 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227111; cv=none; b=UK+wG9a2JG0jFdq86kMFt/s0YWsGhqgE244yLHggirPXr+PiAjYtF81xl0OAF74xa9arM08r2/JLbV9rKzkX9l7B/vTuL4Wv3oqyD/BoZcrr7VcuPtfCyCWWU7fU/TSsmmjc53nx2zi8mGgVd2+rFihKE59rMUFkS23NILJuxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227111; c=relaxed/simple;
	bh=rwTPkTwXCEUGyeLmvrk6ePr+IaM80FlSNy1BANqxgKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pngkJo/JA4nMPFpiPvSOG4sqnLBqcmsaVh5G19SBsN+OxGHaY4AQo4WWI/powU7gJstBoXU6fOYoVmSxzmroyAIQvVSpAV9EZikG5W64SrWvpQBVioZIimLFBXBzUqvgLu9hRP8g2OrKFQ5mLfX3YWnNXdl1QOd0PSb8j9BsGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=wQaphls2; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=pIciiQgJ; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=phuvrP2Eqi7pl/QsdR98xYyu9IrP2+DRRMrCf7VDFao=;
	t=1723227106;x=1723317106; 
	b=wQaphls2LRSiWPsR9AMsuHlUSWP48KNEOjj/cD9cq9JfB/C8pnHeTrVwCjrB82Nj3uBw8Y91x0nY2Q6LCbPECW8ydRNAGIsSOSbrTfbODpvK3MXTNTXunVljT9hXeXvu+1nOKPr0p1ua8O8YIShQBIhlYC/7wghxz2DehGxhpDI=;
Received: from [10.12.4.25] (port=34190 helo=smtp54.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1scTaC-00HN2U-96; Fri, 09 Aug 2024 20:39:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=phuvrP2Eqi7pl/QsdR98xYyu9IrP2+DRRMrCf7VDFao=; t=1723225160; x=1723315160; 
	b=pIciiQgJs7xnJwckU0/ni4xgZyF/9bC3jykM8ycptev4zb6IhvGDHBI8++BEWSZtmNzumgF+0iW
	nAVqvRN+c3kOQYX1HgBcSjm/em54DVYDYstkGIoQ3TyagSre8MAu2DbcJ/ClG3jDgoZxybQULh9Wr
	Ebm2OaNmSAjJgEKOJxI=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1scTZr-00000005YEC-1m9e; Fri, 09 Aug 2024 20:39:00 +0300
Message-ID: <d4be81b0-5e8f-484e-b602-d3774dcc0c96@jiaxyga.com>
Date: Fri, 9 Aug 2024 20:38:32 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] dt-bindings: nfc: nxp,nci: Document PN553
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rafael@kernel.org,
 viresh.kumar@linaro.org, kees@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, ulf.hansson@linaro.org, andre.przywara@arm.com,
 quic_rjendra@quicinc.com, davidwronek@gmail.com, neil.armstrong@linaro.org,
 heiko.stuebner@cherry.de, rafal@milecki.pl, macromorgan@hotmail.com,
 linus.walleij@linaro.org, lpieralisi@kernel.org,
 dmitry.baryshkov@linaro.org, fekz115@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, danila@jiaxyga.com
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-7-danila@jiaxyga.com>
 <493466e6-d83b-4d91-93a5-233d6da1fdd8@kernel.org>
Content-Language: en-US
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <493466e6-d83b-4d91-93a5-233d6da1fdd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD90E4B1D041588DA6EB478F73646A3361881B6FAD510181691182A05F53808504095694BD5A087F37BD27678DDAA806314E83102A95D78A8529A733DB4984B798B77B46462DFFF61CB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E99F7FC786761FD8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7495A032B936E882FEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F368EF209656A70DD9F7E099F0EA1446EDACC9A266FF115D8DFA471835C12D1D9774AD6D5ED66289B5259CC434672EE6371117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE70F3DDF2BBF19B93A9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE70C7584EF2E30C7F8D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C0070C8203D0E31347CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6D0C9BB9AE6BD5D69089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5D565A41581FB33925002B1117B3ED6961548E492E5819C8514DB8790748E3E77823CB91A9FED034534781492E4B8EEADF5E532225D4D775BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFBF51DE5021D6041C212071FD93DF42592C0936AEB9AB78F958EB8D9FBC4FF7936F890FCD3CEE011B5CC6C73BB6D1AD531F20FE5B433C22636A2C52244623A556C72BDC2C2EE38ED85218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj8itOOD08jjbD7sdZ7nM0tQ==
X-Mailru-Sender: A29E055712C5B697A0B4B50D4D88F0E88C3021178ED08D91B951B70A5BD4BD8E661AE61ED64D2CA91E1E156D000DABDB210985D6C440852E55B4A2144138A88088F510C62CFD139357C462056C5AD9112068022A3E05D37EB4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C8E67823F42E1F4B408937B8574763860C25E98424E40264049FFFDB7839CE9E86E20EDB9D704779897A7B374FECF5877A738D2235EDC0680DB83056E6517CC5
X-7FA49CB5: 0D63561A33F958A51B1584A225D0FACF6A4DC84D059B1229CDB87A87303EAF3F8941B15DA834481FA18204E546F3947C6633242DC0339950F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375A3B25A3A11CE7E4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C341E1C46B3B04646035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj8itOOD08jjYkHk3oOvjhYA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 8/9/24 08:39, Krzysztof Kozlowski wrote:
> On 08/08/2024 20:40, Danila Tikhonov wrote:
>> The PN553 is another NFC chip from NXP, document the compatible in the
>> bindings.
>>
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> ---
>>   Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
>> index 6924aff0b2c5..364b36151180 100644
>> --- a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
>> +++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
>> @@ -17,6 +17,7 @@ properties:
>>             - enum:
>>                 - nxp,nq310
>>                 - nxp,pn547
>> +              - nxp,pn553
> Keep the list ordered.
>
> Best regards,
> Krzysztof
>
Thanks for your comment.

Then I will fix it for nxp,pn547 too in this patch. Do you mind?

---
Best wishes,
Danila.


