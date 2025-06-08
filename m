Return-Path: <linux-pm+bounces-28251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9AAD1429
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282677A5B0D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA91A239D;
	Sun,  8 Jun 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxWihf5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C83224FA;
	Sun,  8 Jun 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749413772; cv=none; b=KBgeRNZUQ8k8Jczn3shg/OC7oUycVqjsme1mvYAlDAOYI0pD3QFtPXr16r60A/tAE7M3hOi8pKFSxJ4FaAR4V+IscWmXgsOnDn/g6gie1yJCyipHWz12+9n9x/QMKz+vCg4Cu+95vfVajZdQQ4vOz6M89JFBEHtgOInuTPuOWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749413772; c=relaxed/simple;
	bh=Zx99mTGDyI9wNhPFH1HycDpWouTtdJwY2KghgkzAwMA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=ZOv6uICsfy47vAeOWL7Fb8Zq/kSrGEi+sGSXzOs4+g6UC88euI2q3XuhnJky49pIWxX6r8rLKvBRzFfrxjLMPKJSt3h+Xq7FD4ynpKw+hsxnEF8e5G0q1eiJEdklYXWtMZxEoQrlyjki1zg+TIG3h7TxqTrwWmv542XtFSl/xoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxWihf5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2808BC4CEF3;
	Sun,  8 Jun 2025 20:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749413771;
	bh=Zx99mTGDyI9wNhPFH1HycDpWouTtdJwY2KghgkzAwMA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ZxWihf5pGiSbnpoh+bo0KA+yM8CP3/WMVk4Cusrjv8UfHdZuhMUZa7G+VMbfBq18C
	 rRRT/8k2t+70yuuh7BjVQzbbxydxBDMRexHbF3Ngl2+SsDBTyWXA/DgZbWaHBZdII4
	 DkboUwpLuzKdNVv3KXe7dmeHcPRsrKmr03TdDN8LbLJCWweMcOCCVgbxPIvgSouu5c
	 kfmURVwMwGhocEopvnS2za7Oe8eEPWtA/KTjgOVIKDUtTStopN8evKlWl1eLXGcKtb
	 DfZaO5JPnsreJy/d7pWa/QKNpoMlrwm+3xiTE8MVa8fGEIrDP5bDAj656IMsUcEhix
	 KV+Pq4nOepBlA==
Content-Type: multipart/mixed; boundary="------------mMPJXQTdp5jjwHYKdLNs1Lq0"
Message-ID: <c76fe3f8-8884-4769-af69-a9a527d2a202@kernel.org>
Date: Sun, 8 Jun 2025 22:16:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] power: supply: core: battery-info: fully switch to
 fwnode
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
 <20250430-psy-core-convert-to-fwnode-v2-3-f9643b958677@collabora.com>
 <68792092-4689-4e3e-8dbb-9157889f1a3d@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <68792092-4689-4e3e-8dbb-9157889f1a3d@kernel.org>

This is a multi-part message in MIME format.
--------------mMPJXQTdp5jjwHYKdLNs1Lq0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8-Jun-25 9:57 PM, Hans de Goede wrote:
> Hi Sebastian,
> On 30-Apr-25 12:54 AM, Sebastian Reichel wrote:
>> Also use fwnode based parsing for "ocv-capacity-celsius" and
>> "resistance-temp-table", so that any DT specific bits are
>> removed from the power-supply core.
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I have been testing this converting the ug3105 driver to
> use power_supply_batinfo_ocv2cap(), replacing the hardcoded
> ocv -> capacity table in that driver.
> 
> While testing I hit a bug and while looking closer at this
> patch it needs more work on top of fixing that bug.
> 
> See comments inline, also I've attached 3 fixup patches
> which can be squashed into this patch to address the remarks.
> 
>> ---
>>  drivers/power/supply/power_supply_core.c | 109 ++++++++++++++++++-------------
>>  1 file changed, 63 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 89947f1fe610d8a75756e1e4e5339b06349f9ab8..a8d1fe66e2486a833ccaa3ed77b861c6e52c5760 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -585,32 +585,19 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  {
>>  	struct power_supply_resistance_temp_table *resist_table;
>>  	struct power_supply_battery_info *info;
>> -	struct device_node *battery_np = NULL;
>> -	struct fwnode_reference_args args;
>> -	struct fwnode_handle *fwnode = NULL;
>> +	struct fwnode_handle *srcnode, *fwnode;
>>  	const char *value;
>> -	int err, len, index;
>> -	const __be32 *list;
>> +	int err, len, index, proplen;
>> +	u32 *propdata;
> 
> propname which is also a local-variable for a temporary
> malloc-ed buffer uses __free(kfree) instead of explicit
> kfree() calls IMHO it would be good to do that here too.
> 
> This requires declaring it inside the
> "for (index = 0; index < len; index++)" loop like how
> this is done for propname, so that it gets freed on
> every loop iteration.
> 
> 
>>  	u32 min_max[2];
>>  
>> -	if (psy->dev.of_node) {
>> -		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
>> -		if (!battery_np)
>> -			return -ENODEV;
>> +	srcnode = dev_fwnode(&psy->dev);
>> +	if (!srcnode && psy->dev.parent)
>> +		srcnode = dev_fwnode(psy->dev.parent);
>>  
>> -		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
>> -	} else if (psy->dev.parent) {
>> -		err = fwnode_property_get_reference_args(
>> -					dev_fwnode(psy->dev.parent),
>> -					"monitored-battery", NULL, 0, 0, &args);
>> -		if (err)
>> -			return err;
>> -
>> -		fwnode = args.fwnode;
>> -	}
>> -
>> -	if (!fwnode)
>> -		return -ENOENT;
>> +	fwnode = fwnode_find_reference(srcnode, "monitored-battery", 0);
>> +	if (IS_ERR(fwnode))
>> +		return PTR_ERR(fwnode);
>>  
>>  	err = fwnode_property_read_string(fwnode, "compatible", &value);
>>  	if (err)
>> @@ -740,15 +727,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  		info->temp_max = min_max[1];
>>  	}
>>  
>> -	/*
>> -	 * The below code uses raw of-data parsing to parse
>> -	 * /schemas/types.yaml#/definitions/uint32-matrix
>> -	 * data, so for now this is only support with of.
>> -	 */
>> -	if (!battery_np)
>> -		goto out_ret_pointer;
>> -
>> -	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
>> +	len = fwnode_property_count_u32(fwnode, "ocv-capacity-celsius");
>>  	if (len < 0 && len != -EINVAL) {
>>  		err = len;
>>  		goto out_put_node;
>> @@ -757,13 +736,13 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  		err = -EINVAL;
>>  		goto out_put_node;
>>  	} else if (len > 0) {
>> -		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
>> +		fwnode_property_read_u32_array(fwnode, "ocv-capacity-celsius",
>>  					   info->ocv_temp, len);
>>  	}
>>  
>>  	for (index = 0; index < len; index++) {
>>  		struct power_supply_battery_ocv_table *table;
>> -		int i, tab_len, size;
>> +		int i, tab_len;
>>  
>>  		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
>>  							 index);
>> @@ -772,60 +751,98 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  			err = -ENOMEM;
>>  			goto out_put_node;
>>  		}
>> -		list = of_get_property(battery_np, propname, &size);
>> -		if (!list || !size) {
>> +		proplen = fwnode_property_count_u32(fwnode, propname);
>> +		if (proplen < 0 || proplen % 2 != 0) {
>>  			dev_err(&psy->dev, "failed to get %s\n", propname);
>>  			power_supply_put_battery_info(psy, info);
>>  			err = -EINVAL;
>>  			goto out_put_node;
>>  		}
>> +		propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
> 
> As mentioned above I suggest to use the following here instead:
> 
> 		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
> 		
> 
>> +		if (!propdata) {
>> +			kfree(propname);
> 
> propname must NOT be free-ed here since it is marked __free(kfree),
> freeing it here will cause a double-free bug.
> 
>> +			power_supply_put_battery_info(psy, info);
>> +			err = -EINVAL;
>> +			goto out_put_node;
>> +		}
>> +		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
>> +		if (err < 0) {
>> +			dev_err(&psy->dev, "failed to get %s\n", propname);
>> +			kfree(propname);
> 
> same as above.
> 
>> +			kfree(propdata);
> 
> with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.
> 
>> +			power_supply_put_battery_info(psy, info);
>> +			goto out_put_node;
>> +		}
>>  
>> -		tab_len = size / (2 * sizeof(__be32));
>> +		tab_len = proplen / 2;
>>  		info->ocv_table_size[index] = tab_len;
>>  
>>  		info->ocv_table[index] = table =
>>  			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
>>  		if (!info->ocv_table[index]) {
>> +			kfree(propdata);
> 
> with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.
> 
>>  			power_supply_put_battery_info(psy, info);
>>  			err = -ENOMEM;
>>  			goto out_put_node;
>>  		}
>>  
>>  		for (i = 0; i < tab_len; i++) {
>> -			table[i].ocv = be32_to_cpu(*list);
>> -			list++;
>> -			table[i].capacity = be32_to_cpu(*list);
>> -			list++;
>> +			table[i].ocv = propdata[i*2];
>> +			table[i].capacity = propdata[i*2+1];
>>  		}
>> +
>> +		kfree(propdata);
> 
> with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.
> 
>>  	}
>>  
>> -	list = of_get_property(battery_np, "resistance-temp-table", &len);
>> -	if (!list || !len)
>> +	proplen = fwnode_property_count_u32(fwnode, "resistance-temp-table");
> 
> This will return -EINVAL when the property does not exist, making
> power_supply_get_battery_info() always fail when there is no
> "resistance-temp-table" in the battery fwnode. See the attached fixup
> patch for a suggested fix.
> 
>> +	if (proplen < 0 || proplen % 2 != 0) {
>> +		power_supply_put_battery_info(psy, info);
>> +		err = -ENOMEM;
> 
> -ENOMEM is the wrong error code here.
> 
>>  		goto out_ret_pointer;
> 
> This should be "goto out_put_node" since this is an error path.
> 
>> +	} else if (proplen == 0) {
>> +		goto out_ret_pointer;
>> +	}
>>  
>> -	info->resist_table_size = len / (2 * sizeof(__be32));
>> +	propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
> 
> As mentioned above I suggest to use the following here instead:
> 
> 		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);

Ok, so this does not work, because we jump over this causing
propdata to not get initialized, but the __free(kfree) still
triggers.

Lesson learned: do not use modern C style mixing of declarations
and statements together with __free().

Attached are updated fixup patches which do not make things crash.

Regards,

Hans




> 
>> +	if (!propdata) {
>> +		power_supply_put_battery_info(psy, info);
>> +		err = -ENOMEM;
>> +		goto out_ret_pointer;
> 
> This should be "goto out_put_node" since this is an error path.
> 
>> +	}
>> +
>> +	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
>> +					     propdata, proplen);
>> +	if (err < 0) {
>> +		kfree(propdata);
> 
> with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.
> 
>> +		power_supply_put_battery_info(psy, info);
>> +		goto out_put_node;
>> +	}
>> +
>> +	info->resist_table_size = proplen / 2;
>>  	info->resist_table = resist_table = devm_kcalloc(&psy->dev,
>>  							 info->resist_table_size,
>>  							 sizeof(*resist_table),
>>  							 GFP_KERNEL);
>>  	if (!info->resist_table) {
>> +		kfree(propdata);
> 
> with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.
> 
>>  		power_supply_put_battery_info(psy, info);
>>  		err = -ENOMEM;
>>  		goto out_put_node;
>>  	}
>>  
>>  	for (index = 0; index < info->resist_table_size; index++) {
>> -		resist_table[index].temp = be32_to_cpu(*list++);
>> -		resist_table[index].resistance = be32_to_cpu(*list++);
>> +		resist_table[index].temp = propdata[index*2];
>> +		resist_table[index].resistance = propdata[index*2+1];
>>  	}
>>  
>> +	kfree(propdata);
> 
> with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.
> 
>> +
>>  out_ret_pointer:
>>  	/* Finally return the whole thing */
>>  	*info_out = info;
>>  
>>  out_put_node:
>>  	fwnode_handle_put(fwnode);
>> -	of_node_put(battery_np);
>>  	return err;
>>  }
>>  EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
>>
> 
> Regards,
> 
> Hans
> 
> 

--------------mMPJXQTdp5jjwHYKdLNs1Lq0
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-fixup-power-supply-core-battery-info-fully-switch-to.patch"
Content-Disposition: attachment;
 filename*0="0004-fixup-power-supply-core-battery-info-fully-switch-to.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2OGQyNDE0ZDIwMTA4MzkwNGRhZDgzYWY0ZWJiMmMzNWZjODUwYjc5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDggSnVuIDIwMjUgMjE6MTg6MTEgKzAyMDAKU3ViamVjdDogW1BBVENI
IDA0LzEwXSBmaXh1cCEgcG93ZXI6IHN1cHBseTogY29yZTogYmF0dGVyeS1pbmZvOiBmdWxs
eSBzd2l0Y2gKIHRvIGZ3bm9kZQoKQWZ0ZXIgKCJwb3dlcjogc3VwcGx5OiBjb3JlOiBiYXR0
ZXJ5LWluZm86IGZ1bGx5IHN3aXRjaCB0byBmd25vZGUiKQpwb3dlcl9zdXBwbHlfZ2V0X2Jh
dHRlcnlfaW5mbygpIHdpbGwgYWx3YXlzIGZhaWwgZm9yIGJhdHRlcnkgZndub2Rlcwp3aGlj
aCBkbyBub3QgZGVmaW5lIGEgInJlc2lzdGFuY2UtdGVtcC10YWJsZSIuCgpGaXggdGhpcyBi
eSBjbGVhbmx5IGV4aXRpbmcgb24gYm90aCAwIGFuZCBFSU5WQUwgcmV0dXJucyBmcm9tCmZ3
bm9kZV9wcm9wZXJ0eV9jb3VudF91MzIoZndub2RlLCAicmVzaXN0YW5jZS10ZW1wLXRhYmxl
Iikgd2hpY2gKaW5kaWNhdGVzIHRoYXQgdGhlIHByb3BlcnR5IGlzIGVtcHR5IG9yIG5vdCB0
aGVyZS4KCldoaWxlIGF0IGl0IGFsc28gZml4OgoKMS4gVGhlIHdlaXJkIC1FTk9NRU0gcmV0
dXJuIGZvciBvdGhlciBlcnJvcnMuIEZvciBvdGhlciBlcnJvcnMKcHJvcGFnYXRlIHRoZSBl
eGlzdGluZyBlcnJvciBvciAtRUlOVkFMIGZvciBhbiBvZGQgcHJvcGxlbi4KMi4gV3Jvbmds
eSB1c2luZyAiZ290byBvdXRfcmV0X3BvaW50ZXIiIG9uIGVycm9ycywgb3V0X3JldF9wb2lu
dGVyCnNob3VsZCBvbmx5IGJlIHVzZWQgb24gc3VjY2VzcywgZXJyb3IgcGF0aHMgc2hvdWxk
IHVzZQpvdXRfcHV0X25vZGU7CgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoYW5z
Z0BrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvcG93ZXIvc3VwcGx5L3Bvd2VyX3N1cHBseV9j
b3JlLmMgfCAxMyArKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5
L3Bvd2VyX3N1cHBseV9jb3JlLmMgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBw
bHlfY29yZS5jCmluZGV4IGE4ZDFmZTY2ZTI0OC4uOWJiYzNiZTJlNDgzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfY29yZS5jCisrKyBiL2RyaXZl
cnMvcG93ZXIvc3VwcGx5L3Bvd2VyX3N1cHBseV9jb3JlLmMKQEAgLTc5NSwxOSArNzk1LDIw
IEBAIGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3Vw
cGx5ICpwc3ksCiAJfQogCiAJcHJvcGxlbiA9IGZ3bm9kZV9wcm9wZXJ0eV9jb3VudF91MzIo
Zndub2RlLCAicmVzaXN0YW5jZS10ZW1wLXRhYmxlIik7Ci0JaWYgKHByb3BsZW4gPCAwIHx8
IHByb3BsZW4gJSAyICE9IDApIHsKKwlpZiAocHJvcGxlbiA9PSAwIHx8IHByb3BsZW4gPT0g
LUVJTlZBTCkgeworCQllcnIgPSAwOworCQlnb3RvIG91dF9yZXRfcG9pbnRlcjsKKwl9IGVs
c2UgaWYgKHByb3BsZW4gPCAwIHx8IHByb3BsZW4gJSAyICE9IDApIHsKIAkJcG93ZXJfc3Vw
cGx5X3B1dF9iYXR0ZXJ5X2luZm8ocHN5LCBpbmZvKTsKLQkJZXJyID0gLUVOT01FTTsKLQkJ
Z290byBvdXRfcmV0X3BvaW50ZXI7Ci0JfSBlbHNlIGlmIChwcm9wbGVuID09IDApIHsKLQkJ
Z290byBvdXRfcmV0X3BvaW50ZXI7CisJCWVyciA9IChwcm9wbGVuIDwgMCkgPyBwcm9wbGVu
IDogLUVJTlZBTDsKKwkJZ290byBvdXRfcHV0X25vZGU7CiAJfQogCiAJcHJvcGRhdGEgPSBr
Y2FsbG9jKHByb3BsZW4sIHNpemVvZigqcHJvcGRhdGEpLCBHRlBfS0VSTkVMKTsKIAlpZiAo
IXByb3BkYXRhKSB7CiAJCXBvd2VyX3N1cHBseV9wdXRfYmF0dGVyeV9pbmZvKHBzeSwgaW5m
byk7CiAJCWVyciA9IC1FTk9NRU07Ci0JCWdvdG8gb3V0X3JldF9wb2ludGVyOworCQlnb3Rv
IG91dF9wdXRfbm9kZTsKIAl9CiAKIAllcnIgPSBmd25vZGVfcHJvcGVydHlfcmVhZF91MzJf
YXJyYXkoZndub2RlLCAicmVzaXN0YW5jZS10ZW1wLXRhYmxlIiwKLS0gCjIuNDkuMAoK
--------------mMPJXQTdp5jjwHYKdLNs1Lq0
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-fixup-power-supply-core-battery-info-fully-switch-to.patch"
Content-Disposition: attachment;
 filename*0="0005-fixup-power-supply-core-battery-info-fully-switch-to.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxZTJkNTRiMWM5NDYwNzU1OTBkMDExZGExN2Q5Njc5NmVkZTU4ODk0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDggSnVuIDIwMjUgMjE6Mzc6NTkgKzAyMDAKU3ViamVjdDogW1BBVENI
IDA1LzEwXSBmaXh1cCEgcG93ZXI6IHN1cHBseTogY29yZTogYmF0dGVyeS1pbmZvOiBmdWxs
eSBzd2l0Y2gKIHRvIGZ3bm9kZQoKcHJvcG5hbWUgbXVzdCBOT1QgYmUgbWFudWFsbHkgZnJl
ZS1lZCBoZXJlIHNpbmNlIGl0IGlzIG1hcmtlZApfX2ZyZWUoa2ZyZWUpLCBmcmVlaW5nIGl0
IHdpbGwgY2F1c2UgYSBkb3VibGUtZnJlZSBidWcuCgpBbHNvIG1vdmUgcHJvcGRhdGEgdG8g
YmUgYSBfX2ZyZWUoa2ZyZWUpIHZhbHVlIGZvciBjb25zaXN0ZW5jeQphbmQgYWxzbyBmb3Ig
Y2xlYW5lciBjb2RlLgoKU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGFuc2dAa2Vy
bmVsLm9yZz4KLS0tCiBkcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfY29yZS5j
IHwgMTUgKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9w
b3dlcl9zdXBwbHlfY29yZS5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5
X2NvcmUuYwppbmRleCA5YmJjM2JlMmU0ODMuLmYyYzc5ZjE1ODM4ZCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5X2NvcmUuYworKysgYi9kcml2ZXJz
L3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfY29yZS5jCkBAIC01ODgsNyArNTg4LDcgQEAg
aW50IHBvd2VyX3N1cHBseV9nZXRfYmF0dGVyeV9pbmZvKHN0cnVjdCBwb3dlcl9zdXBwbHkg
KnBzeSwKIAlzdHJ1Y3QgZndub2RlX2hhbmRsZSAqc3Jjbm9kZSwgKmZ3bm9kZTsKIAljb25z
dCBjaGFyICp2YWx1ZTsKIAlpbnQgZXJyLCBsZW4sIGluZGV4LCBwcm9wbGVuOwotCXUzMiAq
cHJvcGRhdGE7CisJdTMyICpwcm9wZGF0YSBfX2ZyZWUoa2ZyZWUpID0gTlVMTDsKIAl1MzIg
bWluX21heFsyXTsKIAogCXNyY25vZGUgPSBkZXZfZndub2RlKCZwc3ktPmRldik7CkBAIC03
NTgsOSArNzU4LDkgQEAgaW50IHBvd2VyX3N1cHBseV9nZXRfYmF0dGVyeV9pbmZvKHN0cnVj
dCBwb3dlcl9zdXBwbHkgKnBzeSwKIAkJCWVyciA9IC1FSU5WQUw7CiAJCQlnb3RvIG91dF9w
dXRfbm9kZTsKIAkJfQotCQlwcm9wZGF0YSA9IGtjYWxsb2MocHJvcGxlbiwgc2l6ZW9mKCpw
cm9wZGF0YSksIEdGUF9LRVJORUwpOworCisJCXUzMiAqcHJvcGRhdGEgX19mcmVlKGtmcmVl
KSA9IGtjYWxsb2MocHJvcGxlbiwgc2l6ZW9mKCpwcm9wZGF0YSksIEdGUF9LRVJORUwpOwog
CQlpZiAoIXByb3BkYXRhKSB7Ci0JCQlrZnJlZShwcm9wbmFtZSk7CiAJCQlwb3dlcl9zdXBw
bHlfcHV0X2JhdHRlcnlfaW5mbyhwc3ksIGluZm8pOwogCQkJZXJyID0gLUVJTlZBTDsKIAkJ
CWdvdG8gb3V0X3B1dF9ub2RlOwpAQCAtNzY4LDggKzc2OCw2IEBAIGludCBwb3dlcl9zdXBw
bHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpwc3ksCiAJCWVyciA9
IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShmd25vZGUsIHByb3BuYW1lLCBwcm9w
ZGF0YSwgcHJvcGxlbik7CiAJCWlmIChlcnIgPCAwKSB7CiAJCQlkZXZfZXJyKCZwc3ktPmRl
diwgImZhaWxlZCB0byBnZXQgJXNcbiIsIHByb3BuYW1lKTsKLQkJCWtmcmVlKHByb3BuYW1l
KTsKLQkJCWtmcmVlKHByb3BkYXRhKTsKIAkJCXBvd2VyX3N1cHBseV9wdXRfYmF0dGVyeV9p
bmZvKHBzeSwgaW5mbyk7CiAJCQlnb3RvIG91dF9wdXRfbm9kZTsKIAkJfQpAQCAtNzgwLDcg
Kzc3OCw2IEBAIGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93
ZXJfc3VwcGx5ICpwc3ksCiAJCWluZm8tPm9jdl90YWJsZVtpbmRleF0gPSB0YWJsZSA9CiAJ
CQlkZXZtX2tjYWxsb2MoJnBzeS0+ZGV2LCB0YWJfbGVuLCBzaXplb2YoKnRhYmxlKSwgR0ZQ
X0tFUk5FTCk7CiAJCWlmICghaW5mby0+b2N2X3RhYmxlW2luZGV4XSkgewotCQkJa2ZyZWUo
cHJvcGRhdGEpOwogCQkJcG93ZXJfc3VwcGx5X3B1dF9iYXR0ZXJ5X2luZm8ocHN5LCBpbmZv
KTsKIAkJCWVyciA9IC1FTk9NRU07CiAJCQlnb3RvIG91dF9wdXRfbm9kZTsKQEAgLTc5MCw4
ICs3ODcsNiBAQCBpbnQgcG93ZXJfc3VwcGx5X2dldF9iYXR0ZXJ5X2luZm8oc3RydWN0IHBv
d2VyX3N1cHBseSAqcHN5LAogCQkJdGFibGVbaV0ub2N2ID0gcHJvcGRhdGFbaSoyXTsKIAkJ
CXRhYmxlW2ldLmNhcGFjaXR5ID0gcHJvcGRhdGFbaSoyKzFdOwogCQl9Ci0KLQkJa2ZyZWUo
cHJvcGRhdGEpOwogCX0KIAogCXByb3BsZW4gPSBmd25vZGVfcHJvcGVydHlfY291bnRfdTMy
KGZ3bm9kZSwgInJlc2lzdGFuY2UtdGVtcC10YWJsZSIpOwpAQCAtODE0LDcgKzgwOSw2IEBA
IGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3VwcGx5
ICpwc3ksCiAJZXJyID0gZndub2RlX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KGZ3bm9kZSwg
InJlc2lzdGFuY2UtdGVtcC10YWJsZSIsCiAJCQkJCSAgICAgcHJvcGRhdGEsIHByb3BsZW4p
OwogCWlmIChlcnIgPCAwKSB7Ci0JCWtmcmVlKHByb3BkYXRhKTsKIAkJcG93ZXJfc3VwcGx5
X3B1dF9iYXR0ZXJ5X2luZm8ocHN5LCBpbmZvKTsKIAkJZ290byBvdXRfcHV0X25vZGU7CiAJ
fQpAQCAtODI1LDcgKzgxOSw2IEBAIGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5m
byhzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpwc3ksCiAJCQkJCQkJIHNpemVvZigqcmVzaXN0X3Rh
YmxlKSwKIAkJCQkJCQkgR0ZQX0tFUk5FTCk7CiAJaWYgKCFpbmZvLT5yZXNpc3RfdGFibGUp
IHsKLQkJa2ZyZWUocHJvcGRhdGEpOwogCQlwb3dlcl9zdXBwbHlfcHV0X2JhdHRlcnlfaW5m
byhwc3ksIGluZm8pOwogCQllcnIgPSAtRU5PTUVNOwogCQlnb3RvIG91dF9wdXRfbm9kZTsK
QEAgLTgzNiw4ICs4MjksNiBAQCBpbnQgcG93ZXJfc3VwcGx5X2dldF9iYXR0ZXJ5X2luZm8o
c3RydWN0IHBvd2VyX3N1cHBseSAqcHN5LAogCQlyZXNpc3RfdGFibGVbaW5kZXhdLnJlc2lz
dGFuY2UgPSBwcm9wZGF0YVtpbmRleCoyKzFdOwogCX0KIAotCWtmcmVlKHByb3BkYXRhKTsK
LQogb3V0X3JldF9wb2ludGVyOgogCS8qIEZpbmFsbHkgcmV0dXJuIHRoZSB3aG9sZSB0aGlu
ZyAqLwogCSppbmZvX291dCA9IGluZm87Ci0tIAoyLjQ5LjAKCg==

--------------mMPJXQTdp5jjwHYKdLNs1Lq0--

