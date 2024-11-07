Return-Path: <linux-pm+bounces-17106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B9F9C0549
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 13:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01AE1C223BC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62720EA26;
	Thu,  7 Nov 2024 12:07:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7481F4725;
	Thu,  7 Nov 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981275; cv=none; b=c8CxBacsTS1XsRVKzLhIiH0jvxjuPprVq4g4stjC7PJBgWmcPWJ50/AzDHa3QJrpf0ttIOl7hsxmWYn39fPykqIJdCGI0sPx+Pn63r4Dgkqd2GgOMy/2KjnLHilshnO9rgEc3i96atSD9IinsU6jW4a+SRGKbU0Xye/gW4nU/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981275; c=relaxed/simple;
	bh=JkbbxpNAoiEdm28VK858af1vZODED05mCblO6voYd1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eM29oFsYQIonfNkCRkKAmQkkSEKZ5GCHMbDe8AWFpUISjtB4Tl7JVzO889IO7a0Lv4NHfS9VARWfIBg4UwgkiPLTkzxxQ100CaGJfFtaBNWwlrz1kv0wByAClAki57XMPwZXcbtoRnz67B3r1QZZlFjuCcbUABp4hPolWWXcb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkglL4gFFz1SGCJ;
	Thu,  7 Nov 2024 20:06:06 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A6784140136;
	Thu,  7 Nov 2024 20:07:49 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 20:07:49 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 20:07:48 +0800
Message-ID: <ccf33114-4ccd-ed2e-cdbf-84de8525911a@huawei.com>
Date: Thu, 7 Nov 2024 20:07:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/2] hwmon: (acpi_power_meter) Fix fail to load module
 on platform without _PMD method
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>
References: <20241107032626.16682-1-lihuisong@huawei.com>
 <20241107032626.16682-3-lihuisong@huawei.com>
 <CAJZ5v0hcEn_XhBPLstFyvqE=2iCG51wvcbGHf2nKaFJU5ynytQ@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hcEn_XhBPLstFyvqE=2iCG51wvcbGHf2nKaFJU5ynytQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2024/11/7 18:55, Rafael J. Wysocki 写道:
> On Thu, Nov 7, 2024 at 4:37 AM Huisong Li <lihuisong@huawei.com> wrote:
>> As ACPI spec said, _PMD method is optional. The acpi_power_meter
>> shouldn't fail to load when the platform hasn't _PMD method.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> How exactly is this related to the first patch?
They're not related, they're just similar.
Sorry, I should separate them😂
Should I resend them now?
>
>> ---
>>   drivers/hwmon/acpi_power_meter.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>> index 6c8a9c863528..2f1c9d97ad21 100644
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
>> @@ -680,8 +680,9 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
>>   {
>>          int res = 0;
>>
>> +       /* _PMD method is optional. */
>>          res = read_domain_devices(resource);
>> -       if (res)
>> +       if (res != -ENODEV)
>>                  return res;
>>
>>          if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
>> --
>> 2.22.0
>>
>>
> .

