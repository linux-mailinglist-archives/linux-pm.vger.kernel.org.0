Return-Path: <linux-pm+bounces-28249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD702AD1413
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E01168FEC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A921624FE;
	Sun,  8 Jun 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTpXHIwT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF76881E;
	Sun,  8 Jun 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749412640; cv=none; b=pGsGFoaclbL48qspBrKor4f9ikSd+flcIq2fMTm+Ll446h/MQ/tr8Sse51F0oLIg//qJe8enyCa7zpWneYPb3Bnk+WMm7JYlwF6BS7lwOLXgZwzQ4yZHZeLugxF/eBWuX3f3M9UWmdBXs1J7W1F36XnqWFe/0OYqm9ZujkxjGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749412640; c=relaxed/simple;
	bh=ylVWuWbcslRUxp/akiw3ucHCZDJ/urSc/Solwwfox2I=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=akCbFMDUAIqXgSLFGKyz5oK0TK0VJEeUnq5rLCkr6tNSwJtJfowtu+4vg+MKlyq5ym1KcwHqoFfMgASjGcdznE68C+meQSoeEfb9WKI0i1slapE9Gt0f8U9oNVq3MXVGJewt+ZTYydtdQpZRpiOlF+BJitEbBMDJ0od+CnfQDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTpXHIwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C95C4CEEE;
	Sun,  8 Jun 2025 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749412639;
	bh=ylVWuWbcslRUxp/akiw3ucHCZDJ/urSc/Solwwfox2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TTpXHIwTykQ1UeeNuOCO4036kgEyp5Wb874HWOS+3Lv2WGAvHEhBdeJFd4Vz7aF70
	 h3lJfvI6m7gdkF+KA918p+iwAh2x/jF0WMb3oKRTROMKzvgN3/Wb5OKRieGIvRLUrS
	 0PVfSH6RBQvzBsZCXU6qKEsMLePY6bTVpAxpeg1GkIPWLqgU1gJ6SSt6R4V8Ibs4dO
	 iXzpbW+VUpL7sLIvtUnzAg6hlo9kfKACU+TstzgKa6Cz0c9Ctum3lnF0VmBvDn2/Lz
	 QYaWB6RMXHsySMS3zN2s653n3e4C4h5C7eL/byT5YnmFwhS38/3nZEc/Pj+OC/Aabt
	 1PMIFypEuTtyA==
Content-Type: multipart/mixed; boundary="------------FrbKWL0OQveqTjOdyhRgfJWF"
Message-ID: <68792092-4689-4e3e-8dbb-9157889f1a3d@kernel.org>
Date: Sun, 8 Jun 2025 21:57:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] power: supply: core: battery-info: fully switch to
 fwnode
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250430-psy-core-convert-to-fwnode-v2-3-f9643b958677@collabora.com>

This is a multi-part message in MIME format.
--------------FrbKWL0OQveqTjOdyhRgfJWF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,
On 30-Apr-25 12:54 AM, Sebastian Reichel wrote:
> Also use fwnode based parsing for "ocv-capacity-celsius" and
> "resistance-temp-table", so that any DT specific bits are
> removed from the power-supply core.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I have been testing this converting the ug3105 driver to
use power_supply_batinfo_ocv2cap(), replacing the hardcoded
ocv -> capacity table in that driver.

While testing I hit a bug and while looking closer at this
patch it needs more work on top of fixing that bug.

See comments inline, also I've attached 3 fixup patches
which can be squashed into this patch to address the remarks.

> ---
>  drivers/power/supply/power_supply_core.c | 109 ++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 89947f1fe610d8a75756e1e4e5339b06349f9ab8..a8d1fe66e2486a833ccaa3ed77b861c6e52c5760 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -585,32 +585,19 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  {
>  	struct power_supply_resistance_temp_table *resist_table;
>  	struct power_supply_battery_info *info;
> -	struct device_node *battery_np = NULL;
> -	struct fwnode_reference_args args;
> -	struct fwnode_handle *fwnode = NULL;
> +	struct fwnode_handle *srcnode, *fwnode;
>  	const char *value;
> -	int err, len, index;
> -	const __be32 *list;
> +	int err, len, index, proplen;
> +	u32 *propdata;

propname which is also a local-variable for a temporary
malloc-ed buffer uses __free(kfree) instead of explicit
kfree() calls IMHO it would be good to do that here too.

This requires declaring it inside the
"for (index = 0; index < len; index++)" loop like how
this is done for propname, so that it gets freed on
every loop iteration.


>  	u32 min_max[2];
>  
> -	if (psy->dev.of_node) {
> -		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
> -		if (!battery_np)
> -			return -ENODEV;
> +	srcnode = dev_fwnode(&psy->dev);
> +	if (!srcnode && psy->dev.parent)
> +		srcnode = dev_fwnode(psy->dev.parent);
>  
> -		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
> -	} else if (psy->dev.parent) {
> -		err = fwnode_property_get_reference_args(
> -					dev_fwnode(psy->dev.parent),
> -					"monitored-battery", NULL, 0, 0, &args);
> -		if (err)
> -			return err;
> -
> -		fwnode = args.fwnode;
> -	}
> -
> -	if (!fwnode)
> -		return -ENOENT;
> +	fwnode = fwnode_find_reference(srcnode, "monitored-battery", 0);
> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);
>  
>  	err = fwnode_property_read_string(fwnode, "compatible", &value);
>  	if (err)
> @@ -740,15 +727,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  		info->temp_max = min_max[1];
>  	}
>  
> -	/*
> -	 * The below code uses raw of-data parsing to parse
> -	 * /schemas/types.yaml#/definitions/uint32-matrix
> -	 * data, so for now this is only support with of.
> -	 */
> -	if (!battery_np)
> -		goto out_ret_pointer;
> -
> -	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
> +	len = fwnode_property_count_u32(fwnode, "ocv-capacity-celsius");
>  	if (len < 0 && len != -EINVAL) {
>  		err = len;
>  		goto out_put_node;
> @@ -757,13 +736,13 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  		err = -EINVAL;
>  		goto out_put_node;
>  	} else if (len > 0) {
> -		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
> +		fwnode_property_read_u32_array(fwnode, "ocv-capacity-celsius",
>  					   info->ocv_temp, len);
>  	}
>  
>  	for (index = 0; index < len; index++) {
>  		struct power_supply_battery_ocv_table *table;
> -		int i, tab_len, size;
> +		int i, tab_len;
>  
>  		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
>  							 index);
> @@ -772,60 +751,98 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  			err = -ENOMEM;
>  			goto out_put_node;
>  		}
> -		list = of_get_property(battery_np, propname, &size);
> -		if (!list || !size) {
> +		proplen = fwnode_property_count_u32(fwnode, propname);
> +		if (proplen < 0 || proplen % 2 != 0) {
>  			dev_err(&psy->dev, "failed to get %s\n", propname);
>  			power_supply_put_battery_info(psy, info);
>  			err = -EINVAL;
>  			goto out_put_node;
>  		}
> +		propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);

As mentioned above I suggest to use the following here instead:

		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
		

> +		if (!propdata) {
> +			kfree(propname);

propname must NOT be free-ed here since it is marked __free(kfree),
freeing it here will cause a double-free bug.

> +			power_supply_put_battery_info(psy, info);
> +			err = -EINVAL;
> +			goto out_put_node;
> +		}
> +		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
> +		if (err < 0) {
> +			dev_err(&psy->dev, "failed to get %s\n", propname);
> +			kfree(propname);

same as above.

> +			kfree(propdata);

with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.

> +			power_supply_put_battery_info(psy, info);
> +			goto out_put_node;
> +		}
>  
> -		tab_len = size / (2 * sizeof(__be32));
> +		tab_len = proplen / 2;
>  		info->ocv_table_size[index] = tab_len;
>  
>  		info->ocv_table[index] = table =
>  			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
>  		if (!info->ocv_table[index]) {
> +			kfree(propdata);

with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.

>  			power_supply_put_battery_info(psy, info);
>  			err = -ENOMEM;
>  			goto out_put_node;
>  		}
>  
>  		for (i = 0; i < tab_len; i++) {
> -			table[i].ocv = be32_to_cpu(*list);
> -			list++;
> -			table[i].capacity = be32_to_cpu(*list);
> -			list++;
> +			table[i].ocv = propdata[i*2];
> +			table[i].capacity = propdata[i*2+1];
>  		}
> +
> +		kfree(propdata);

with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.

>  	}
>  
> -	list = of_get_property(battery_np, "resistance-temp-table", &len);
> -	if (!list || !len)
> +	proplen = fwnode_property_count_u32(fwnode, "resistance-temp-table");

This will return -EINVAL when the property does not exist, making
power_supply_get_battery_info() always fail when there is no
"resistance-temp-table" in the battery fwnode. See the attached fixup
patch for a suggested fix.

> +	if (proplen < 0 || proplen % 2 != 0) {
> +		power_supply_put_battery_info(psy, info);
> +		err = -ENOMEM;

-ENOMEM is the wrong error code here.

>  		goto out_ret_pointer;

This should be "goto out_put_node" since this is an error path.

> +	} else if (proplen == 0) {
> +		goto out_ret_pointer;
> +	}
>  
> -	info->resist_table_size = len / (2 * sizeof(__be32));
> +	propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);

As mentioned above I suggest to use the following here instead:

		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);

> +	if (!propdata) {
> +		power_supply_put_battery_info(psy, info);
> +		err = -ENOMEM;
> +		goto out_ret_pointer;

This should be "goto out_put_node" since this is an error path.

> +	}
> +
> +	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
> +					     propdata, proplen);
> +	if (err < 0) {
> +		kfree(propdata);

with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.

> +		power_supply_put_battery_info(psy, info);
> +		goto out_put_node;
> +	}
> +
> +	info->resist_table_size = proplen / 2;
>  	info->resist_table = resist_table = devm_kcalloc(&psy->dev,
>  							 info->resist_table_size,
>  							 sizeof(*resist_table),
>  							 GFP_KERNEL);
>  	if (!info->resist_table) {
> +		kfree(propdata);

with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.

>  		power_supply_put_battery_info(psy, info);
>  		err = -ENOMEM;
>  		goto out_put_node;
>  	}
>  
>  	for (index = 0; index < info->resist_table_size; index++) {
> -		resist_table[index].temp = be32_to_cpu(*list++);
> -		resist_table[index].resistance = be32_to_cpu(*list++);
> +		resist_table[index].temp = propdata[index*2];
> +		resist_table[index].resistance = propdata[index*2+1];
>  	}
>  
> +	kfree(propdata);

with the suggested "u32 *propdata __free(kfree)" this can and must be dropped.

> +
>  out_ret_pointer:
>  	/* Finally return the whole thing */
>  	*info_out = info;
>  
>  out_put_node:
>  	fwnode_handle_put(fwnode);
> -	of_node_put(battery_np);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> 

Regards,

Hans



--------------FrbKWL0OQveqTjOdyhRgfJWF
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
--------------FrbKWL0OQveqTjOdyhRgfJWF
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-fixup-power-supply-core-battery-info-fully-switch-to.patch"
Content-Disposition: attachment;
 filename*0="0005-fixup-power-supply-core-battery-info-fully-switch-to.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiOTJhYzIyNmZhNjg4OGQ3YTUzZmM3NjgxNTExMGU3NmUxM2I4NWFlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDggSnVuIDIwMjUgMjE6Mzc6NTkgKzAyMDAKU3ViamVjdDogW1BBVENI
IDA1LzEwXSBmaXh1cCEgcG93ZXI6IHN1cHBseTogY29yZTogYmF0dGVyeS1pbmZvOiBmdWxs
eSBzd2l0Y2gKIHRvIGZ3bm9kZQoKcHJvcG5hbWUgbXVzdCBOT1QgYmUgbWFudWFsbHkgZnJl
ZS1lZCBoZXJlIHNpbmNlIGl0IGlzIG1hcmtlZApfX2ZyZWUoa2ZyZWUpLCBmcmVlaW5nIGl0
IHdpbGwgY2F1c2UgYSBkb3VibGUtZnJlZSBidWcuCgpBbHNvIG1vdmUgcHJvcGRhdGEgdG8g
YmUgYSBfX2ZyZWUoa2ZyZWUpIHZhbHVlIGZvciBjb25zaXN0ZW5jeQphbmQgYWxzbyBmb3Ig
Y2xlYW5lciBjb2RlLgoKU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGFuc2dAa2Vy
bmVsLm9yZz4KLS0tCiBkcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfY29yZS5j
IHwgMTYgKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9zdXBwbHkv
cG93ZXJfc3VwcGx5X2NvcmUuYyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Bvd2VyX3N1cHBs
eV9jb3JlLmMKaW5kZXggOWJiYzNiZTJlNDgzLi4wZTQyYjliYWZjYWIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Bvd2VyX3N1cHBseV9jb3JlLmMKKysrIGIvZHJpdmVy
cy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5X2NvcmUuYwpAQCAtNTg4LDcgKzU4OCw2IEBA
IGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3VwcGx5
ICpwc3ksCiAJc3RydWN0IGZ3bm9kZV9oYW5kbGUgKnNyY25vZGUsICpmd25vZGU7CiAJY29u
c3QgY2hhciAqdmFsdWU7CiAJaW50IGVyciwgbGVuLCBpbmRleCwgcHJvcGxlbjsKLQl1MzIg
KnByb3BkYXRhOwogCXUzMiBtaW5fbWF4WzJdOwogCiAJc3Jjbm9kZSA9IGRldl9md25vZGUo
JnBzeS0+ZGV2KTsKQEAgLTc1OCw5ICs3NTcsOSBAQCBpbnQgcG93ZXJfc3VwcGx5X2dldF9i
YXR0ZXJ5X2luZm8oc3RydWN0IHBvd2VyX3N1cHBseSAqcHN5LAogCQkJZXJyID0gLUVJTlZB
TDsKIAkJCWdvdG8gb3V0X3B1dF9ub2RlOwogCQl9Ci0JCXByb3BkYXRhID0ga2NhbGxvYyhw
cm9wbGVuLCBzaXplb2YoKnByb3BkYXRhKSwgR0ZQX0tFUk5FTCk7CisKKwkJdTMyICpwcm9w
ZGF0YSBfX2ZyZWUoa2ZyZWUpID0ga2NhbGxvYyhwcm9wbGVuLCBzaXplb2YoKnByb3BkYXRh
KSwgR0ZQX0tFUk5FTCk7CiAJCWlmICghcHJvcGRhdGEpIHsKLQkJCWtmcmVlKHByb3BuYW1l
KTsKIAkJCXBvd2VyX3N1cHBseV9wdXRfYmF0dGVyeV9pbmZvKHBzeSwgaW5mbyk7CiAJCQll
cnIgPSAtRUlOVkFMOwogCQkJZ290byBvdXRfcHV0X25vZGU7CkBAIC03NjgsOCArNzY3LDYg
QEAgaW50IHBvd2VyX3N1cHBseV9nZXRfYmF0dGVyeV9pbmZvKHN0cnVjdCBwb3dlcl9zdXBw
bHkgKnBzeSwKIAkJZXJyID0gZndub2RlX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KGZ3bm9k
ZSwgcHJvcG5hbWUsIHByb3BkYXRhLCBwcm9wbGVuKTsKIAkJaWYgKGVyciA8IDApIHsKIAkJ
CWRldl9lcnIoJnBzeS0+ZGV2LCAiZmFpbGVkIHRvIGdldCAlc1xuIiwgcHJvcG5hbWUpOwot
CQkJa2ZyZWUocHJvcG5hbWUpOwotCQkJa2ZyZWUocHJvcGRhdGEpOwogCQkJcG93ZXJfc3Vw
cGx5X3B1dF9iYXR0ZXJ5X2luZm8ocHN5LCBpbmZvKTsKIAkJCWdvdG8gb3V0X3B1dF9ub2Rl
OwogCQl9CkBAIC03ODAsNyArNzc3LDYgQEAgaW50IHBvd2VyX3N1cHBseV9nZXRfYmF0dGVy
eV9pbmZvKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwKIAkJaW5mby0+b2N2X3RhYmxlW2lu
ZGV4XSA9IHRhYmxlID0KIAkJCWRldm1fa2NhbGxvYygmcHN5LT5kZXYsIHRhYl9sZW4sIHNp
emVvZigqdGFibGUpLCBHRlBfS0VSTkVMKTsKIAkJaWYgKCFpbmZvLT5vY3ZfdGFibGVbaW5k
ZXhdKSB7Ci0JCQlrZnJlZShwcm9wZGF0YSk7CiAJCQlwb3dlcl9zdXBwbHlfcHV0X2JhdHRl
cnlfaW5mbyhwc3ksIGluZm8pOwogCQkJZXJyID0gLUVOT01FTTsKIAkJCWdvdG8gb3V0X3B1
dF9ub2RlOwpAQCAtNzkwLDggKzc4Niw2IEBAIGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRl
cnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpwc3ksCiAJCQl0YWJsZVtpXS5vY3YgPSBw
cm9wZGF0YVtpKjJdOwogCQkJdGFibGVbaV0uY2FwYWNpdHkgPSBwcm9wZGF0YVtpKjIrMV07
CiAJCX0KLQotCQlrZnJlZShwcm9wZGF0YSk7CiAJfQogCiAJcHJvcGxlbiA9IGZ3bm9kZV9w
cm9wZXJ0eV9jb3VudF91MzIoZndub2RlLCAicmVzaXN0YW5jZS10ZW1wLXRhYmxlIik7CkBA
IC04MDQsNyArNzk4LDcgQEAgaW50IHBvd2VyX3N1cHBseV9nZXRfYmF0dGVyeV9pbmZvKHN0
cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwKIAkJZ290byBvdXRfcHV0X25vZGU7CiAJfQogCi0J
cHJvcGRhdGEgPSBrY2FsbG9jKHByb3BsZW4sIHNpemVvZigqcHJvcGRhdGEpLCBHRlBfS0VS
TkVMKTsKKwl1MzIgKnByb3BkYXRhIF9fZnJlZShrZnJlZSkgPSBrY2FsbG9jKHByb3BsZW4s
IHNpemVvZigqcHJvcGRhdGEpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIXByb3BkYXRhKSB7CiAJ
CXBvd2VyX3N1cHBseV9wdXRfYmF0dGVyeV9pbmZvKHBzeSwgaW5mbyk7CiAJCWVyciA9IC1F
Tk9NRU07CkBAIC04MTQsNyArODA4LDYgQEAgaW50IHBvd2VyX3N1cHBseV9nZXRfYmF0dGVy
eV9pbmZvKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwKIAllcnIgPSBmd25vZGVfcHJvcGVy
dHlfcmVhZF91MzJfYXJyYXkoZndub2RlLCAicmVzaXN0YW5jZS10ZW1wLXRhYmxlIiwKIAkJ
CQkJICAgICBwcm9wZGF0YSwgcHJvcGxlbik7CiAJaWYgKGVyciA8IDApIHsKLQkJa2ZyZWUo
cHJvcGRhdGEpOwogCQlwb3dlcl9zdXBwbHlfcHV0X2JhdHRlcnlfaW5mbyhwc3ksIGluZm8p
OwogCQlnb3RvIG91dF9wdXRfbm9kZTsKIAl9CkBAIC04MjUsNyArODE4LDYgQEAgaW50IHBv
d2VyX3N1cHBseV9nZXRfYmF0dGVyeV9pbmZvKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwK
IAkJCQkJCQkgc2l6ZW9mKCpyZXNpc3RfdGFibGUpLAogCQkJCQkJCSBHRlBfS0VSTkVMKTsK
IAlpZiAoIWluZm8tPnJlc2lzdF90YWJsZSkgewotCQlrZnJlZShwcm9wZGF0YSk7CiAJCXBv
d2VyX3N1cHBseV9wdXRfYmF0dGVyeV9pbmZvKHBzeSwgaW5mbyk7CiAJCWVyciA9IC1FTk9N
RU07CiAJCWdvdG8gb3V0X3B1dF9ub2RlOwpAQCAtODM2LDggKzgyOCw2IEBAIGludCBwb3dl
cl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpwc3ksCiAJ
CXJlc2lzdF90YWJsZVtpbmRleF0ucmVzaXN0YW5jZSA9IHByb3BkYXRhW2luZGV4KjIrMV07
CiAJfQogCi0Ja2ZyZWUocHJvcGRhdGEpOwotCiBvdXRfcmV0X3BvaW50ZXI6CiAJLyogRmlu
YWxseSByZXR1cm4gdGhlIHdob2xlIHRoaW5nICovCiAJKmluZm9fb3V0ID0gaW5mbzsKLS0g
CjIuNDkuMAoK

--------------FrbKWL0OQveqTjOdyhRgfJWF--

