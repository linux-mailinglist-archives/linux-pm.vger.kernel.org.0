Return-Path: <linux-pm+bounces-14823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A648F9872D4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E429AB2735D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044E614A624;
	Thu, 26 Sep 2024 11:30:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D618EFD4
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350202; cv=none; b=mZE0dUP9SrJwvWsMDL5/pW4hPyH0GPwZ54JoDU7+Sh9Xev99F47ssYuy/+r8F/U6/Bufmou1DSfWEJFEG0hF5P2TJAD3vebJ1nrTnmTwd/qyKJLQhiULvwHoaOEoyucwGT5gSqDDG065bHk2/0QgmUCucqhs6qTe+wk1HNFeVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350202; c=relaxed/simple;
	bh=gGqN7ML0pjN/NFOjJ9IjeW8vgSGF/bYr1IEV9VXcfvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JSxlWyxEH60KNj62WR4OYN3Kwpp15uneTuJe0gqnfkZObD5e0npASCLTazp0S3f7YaXk9QQ3QSoP2ywc+8TI0Y4u6Y2wU6XNxjtpOC70gOkVzCoz0wKvxMRgexNofTOLZkaIaj0n0udkklJzauODNIT6kXd3QtArD07uWODNo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XDrtX5Y0JzpW2W;
	Thu, 26 Sep 2024 19:27:48 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B13E1800D5;
	Thu, 26 Sep 2024 19:29:51 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Sep 2024 19:29:50 +0800
Message-ID: <455a6a49-41d2-4a20-9a31-f57ee7a67920@huawei.com>
Date: Thu, 26 Sep 2024 19:29:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] pmdomain: qcom-cpr: Use scope based of_node_put() to
 simplify code.
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <linux-pm@vger.kernel.org>
References: <b5ad81cd-fc95-46f3-8878-3ae3765b5c3d@stanley.mountain>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <b5ad81cd-fc95-46f3-8878-3ae3765b5c3d@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/9/26 17:51, Dan Carpenter 写道:
> Hello Zhang Zekun,
> 
> Commit 181c8148556a ("pmdomain: qcom-cpr: Use scope based
> of_node_put() to simplify code.") from Aug 21, 2024 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	drivers/pmdomain/qcom/cpr.c:1058 cpr_get_opp_hz_for_req()
> 	error: uninitialized symbol 'rate'.
> 
> drivers/pmdomain/qcom/cpr.c
>      1036 static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
>      1037                                             struct device *cpu_dev)
>      1038 {
>      1039         struct device_node *ref_np __free(device_node) = NULL;
>      1040         struct device_node *desc_np __free(device_node) =
>      1041                 dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>      1042
>      1043         if (!desc_np)
>      1044                 return 0;
>      1045
>      1046         ref_np = dev_pm_opp_get_of_node(ref);
>      1047         if (!ref_np)
>      1048                 return 0;
>      1049
>      1050         for_each_available_child_of_node_scoped(desc_np, child_np) {
>      1051                 struct device_node *child_req_np __free(device_node) =
>      1052                         of_parse_phandle(child_np, "required-opps", 0);
>      1053
>      1054                 if (child_req_np == ref_np) {
>      1055                         u64 rate;
>      1056
>      1057                         of_property_read_u64(child_np, "opp-hz", &rate);
> --> 1058                         return (unsigned long) rate;
> 
> of_property_read_u64() can fail.  Before rate was initialized to zero.
> 
>      1059                 }
>      1060         }
>      1061
>      1062         return 0;
>      1063 }
> 
> regards,
> dan carpenter

Hi, Dan,

Thanks for your report, I will send a fix patch soon.

Best Regards,
Zekun


