Return-Path: <linux-pm+bounces-39907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D1CDBBAE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 10:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 586ED3001BFE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917D2836A4;
	Wed, 24 Dec 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXpRKMp+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AA2AF1D;
	Wed, 24 Dec 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566876; cv=none; b=LTfIXpjV9eB6Fd9bLtiFIcP7KQHharpQjFaL86bsZvNaNlplhbM0cgGdPRl3H64SvfujPX7Tki8wnH4pRabKEfpRsmsewbG1NzuBOEbiHVnoV0DymXA5NiUb6VN39EaKfpe/3ejfR0Est2+M2qgdOqrhWfdwD7BqL8HnBsRh4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566876; c=relaxed/simple;
	bh=vZYYOJQe2Eiz6HQaUXXDvek8PoCzz8KpifnfcNfTZQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJHYclnRwP4laxFQo5ZuXakD9bm1ErvM3KnG0jyiSxZZAU92s34KVuuxZCYZy/J/NlUvxG/VHIOpCEadk2N2q26LRIh1sAoiqxWZBsEFdC1WqZVx+ov7WBoNDCN3LHXuQVzwtHYucR0j9f7mzoymIjreBc64zMhLvScZ6TLkjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXpRKMp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7692EC4CEFB;
	Wed, 24 Dec 2025 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766566875;
	bh=vZYYOJQe2Eiz6HQaUXXDvek8PoCzz8KpifnfcNfTZQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WXpRKMp+bw0S0pZqRxJ7vH4USkCnWx7kvmirrFpgbLj/QZame22Ny5i5mjmP2HR92
	 AKDIH6kC/Pmtgu4VZzLfzU05ooNZYx2O8jbZe7RawQCRYy3UKogrgOLe88AThh0An9
	 jnGXxbFnMtwpQx7rvx/NbO5TyvXbnKZhFlOlX8h6LUFtF0Pl68nhoc96EDBeBVL0XK
	 N/Xh69pH+yszI+nGZIycmTdLeSK8qwrA49JwGMz3/Jvx/fk1cTFX2g1rkvwT+qJr/+
	 x8Y4l+zGFLTnC2VDWBQZIpjuni7J8jlGmiHnDVkmfSeLVqNX4B4guwOZmqHFohCmjh
	 Cm3G5pSsRFHyA==
Message-ID: <7b48c104-5430-455b-be11-ab23387f88ff@kernel.org>
Date: Wed, 24 Dec 2025 10:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] thermal: qcom: add qmi-cooling driver
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
 amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-5-gaurav.kohli@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251223123227.1317244-5-gaurav.kohli@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2025 13:32, Gaurav Kohli wrote:
> +static int thermal_qmi_new_server(struct qmi_handle *qmi, struct qmi_service *service)
> +{
> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
> +	struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node, service->port };
> +
> +	scoped_guard(mutex, &client->mutex)
> +		kernel_connect(qmi->sock, (struct sockaddr_unsized *)&sq, sizeof(sq), 0);
> +
> +	queue_work(system_highpri_wq, &client->svc_arrive_work);
> +
> +	return 0;
> +}
> +
> +static struct qmi_ops thermal_qmi_event_ops = {

Why this is not const?

From where did you copy this code?

> +	.new_server = thermal_qmi_new_server,
> +	.del_server = thermal_qmi_del_server,
> +	.net_reset = thermal_qmi_net_reset,
> +};
> +
> +static void qmi_tmd_cleanup(struct qmi_tmd_client *client)
> +{
> +	struct qmi_tmd *tmd, *c_next;
> +
> +	guard(mutex)(&client->mutex);
> +
> +	client->connection_active = false;
> +
> +	qmi_handle_release(&client->handle);
> +	cancel_work(&client->svc_arrive_work);
> +	list_for_each_entry_safe(tmd, c_next, &client->cdev_list, node) {
> +		if (tmd->rproc_cdev)
> +			remoteproc_cooling_unregister(tmd->rproc_cdev);
> +
> +		list_del(&tmd->node);
> +	}
> +}
> +
> +/* Parse the controls and allocate a qmi_tmd for each of them */
> +static int qmi_tmd_alloc_cdevs(struct qmi_tmd_client *client)
> +{
> +	struct device *dev = client->dev;
> +	struct qmi_tmd *tmd;
> +	struct device_node *subnode, *node = dev->of_node;
> +	int ret;
> +
> +	for_each_available_child_of_node(node, subnode) {
> +		const char *name;
> +
> +		tmd = devm_kzalloc(dev, sizeof(*tmd), GFP_KERNEL);
> +		if (!tmd)
> +			return dev_err_probe(client->dev, -ENOMEM,
> +					     "Couldn't allocate tmd\n");

You leak nodes.

> +
> +		tmd->type = devm_kasprintf(client->dev, GFP_KERNEL, "%s:%s",
> +						client->name, subnode->name);
> +		if (!tmd->type)
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "Couldn't allocate cooling device name\n");

Everywhere...

> +
> +		if (of_property_read_string(subnode, "label", &name)) {
> +			return dev_err_probe(client->dev, -EINVAL,
> +					     "Failed to parse dev name for %s\n",
> +					     subnode->name);
> +		}
> +
> +		ret = strscpy(tmd->qmi_name, name,
> +			      QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
> +		if (ret == -E2BIG) {
> +			return dev_err_probe(dev, -EINVAL, "TMD label %s is too long\n",
> +					     name);
> +		}
> +
> +		tmd->client = client;
> +		tmd->np = subnode;
> +		tmd->cur_state = 0;
> +		list_add(&tmd->node, &client->cdev_list);
> +	}
> +
> +	if (list_empty(&client->cdev_list))
> +		return dev_err_probe(client->dev, -EINVAL,
> +				     "No cooling devices specified for client %s (%#x)\n",
> +				     client->name, client->id);
> +
> +	return 0;
> +}
> +
> +static int qmi_tmd_client_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qmi_tmd_client *client;
> +	const struct qmi_instance_data *match;
> +	int ret;

Open any existing Linux driver. How does this part look like?

> +	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	client->dev = dev;
> +
> +	match = of_device_get_match_data(dev);
> +	if (!match)
> +		return dev_err_probe(dev, -EINVAL, "No match data\n");
> +
> +	client->id = match->id;
> +	client->name = match->name;
> +
> +	mutex_init(&client->mutex);
> +	INIT_LIST_HEAD(&client->cdev_list);
> +	INIT_WORK(&client->svc_arrive_work, qmi_tmd_svc_arrive);
> +
> +	ret = qmi_tmd_alloc_cdevs(client);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, client);
> +
> +	ret = qmi_handle_init(&client->handle,
> +			      TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN,
> +			      &thermal_qmi_event_ops, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(client->dev, ret, "QMI handle init failed for client %#x\n",
> +			      client->id);
> +
> +	ret = qmi_add_lookup(&client->handle, TMD_SERVICE_ID_V01, TMD_SERVICE_VERS_V01,
> +			     client->id);
> +	if (ret < 0) {
> +		qmi_handle_release(&client->handle);
> +		return dev_err_probe(client->dev, ret, "QMI register failed for client 0x%x\n",
> +			      client->id);
> +	}
> +
> +	return 0;
> +}
> +
> +static void qmi_tmd_client_remove(struct platform_device *pdev)
> +{
> +	struct qmi_tmd_client *client = platform_get_drvdata(pdev);
> +
> +	qmi_tmd_cleanup(client);
> +}
> +
> +static const struct of_device_id qmi_tmd_device_table[] = {
> +	{
> +		.compatible = "qcom,qmi-cooling-cdsp",
> +		.data = &((struct qmi_instance_data) { CDSP_INSTANCE_ID, "cdsp" }),

Please use Linux coding style.

> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qmi_tmd_device_table);
> +
> +static struct platform_driver qmi_tmd_device_driver = {
> +	.probe = qmi_tmd_client_probe,
> +	.remove = qmi_tmd_client_remove,
> +	.driver = {
> +		.name = "qcom-qmi-cooling",
> +		.of_match_table = qmi_tmd_device_table,
> +	},


Best regards,
Krzysztof

