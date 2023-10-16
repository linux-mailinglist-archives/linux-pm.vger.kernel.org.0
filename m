Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133E7CB516
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJPVKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjJPVKY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 17:10:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A706A7
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 14:10:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so3046651f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697490618; x=1698095418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3NTOzADiDVdKOcs9IM9LikyA996SESJ24YGxjfzCGs=;
        b=gpHYkk6Jq8YoUDM+URQRt6LUSw1KWJ7cOE73oTS1LuOHbXM8wgMuV1WPV9t4hTJdqO
         IOrmWF8FGpB/W9yZmRaxaWpaDnKyjsu8S6FOJRcKtvmh6yCXccRbh7olYOVU/g3ivf7I
         VqBNccZBO0w6TkrHPsjxeYzMFhl+Owr9g83QxUejZ1gn5x0Ha/fuE1CzLWElW1XA2WFc
         iBeKUhpBN3k0adYVcgD2BCDh7XQmAl3AdU8azMjaRPTRuknN9FZmoMAlzsNKbOnmdBoS
         /WNVCQwt+7KsRyLz2NBb+7/DYvUYeNfQoJBbDUxxHleuQz4D357F7W6Vz2oLd0ZFarjg
         7Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490618; x=1698095418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3NTOzADiDVdKOcs9IM9LikyA996SESJ24YGxjfzCGs=;
        b=brUkXyb2ghPm8PfdubgHeswOqirjEBWUzcWTMzASE095vIDCidxJlxfzNxABuSx5b3
         YJHcsMamEhVOxygwXF/vGfNjPp7huZ+IXUxq2r+QRBwoOKL+ZiITaLCn7I+OWSjC2S0N
         BkqHzubt+1YD7WEQITbv+Z0GXE9i0OZ86pM0uIaEYYxec3+Yc0TSMk1bVtw8oKQENk2Q
         bk6f76JOvq3AxO7eEtsNdRoT16eF69HAEPIMJ1yC0nhXMqxS6f3VSk/ZENOISKZPwiBV
         75yqvOnlJRY5RwGMejJsXYZAH6VgkCE/nMeZl0Us1da3OhBxjUike/tPj+eBAXEVBRZk
         XjSA==
X-Gm-Message-State: AOJu0YxqwNbzLXxIpRC7EZlLVc70ux1v3fUkWuCLNBjrUlyMAitLcGMa
        xQlqGI79DogHDRSMnurbbic9Kg==
X-Google-Smtp-Source: AGHT+IHLDCnf171f/uBdd4en04OM7yreK9an7sbHI5qHB4oPAHBB4Ay0xCvD0Ocepnr7gXphd3Q4LQ==
X-Received: by 2002:adf:ca8a:0:b0:323:31a6:c1db with SMTP id r10-20020adfca8a000000b0032331a6c1dbmr6436403wrh.21.1697490617483;
        Mon, 16 Oct 2023 14:10:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id d27-20020adf9b9b000000b0031c52e81490sm141932wrc.72.2023.10.16.14.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:10:16 -0700 (PDT)
Message-ID: <13fcd5eb-c9cd-4959-a225-93911afb858a@linaro.org>
Date:   Mon, 16 Oct 2023 23:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] thermal: qcom: add qmi-cooling driver
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20230905-caleb-qmi_cooling-v1-3-5aa39d4164a7@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230905-caleb-qmi_cooling-v1-3-5aa39d4164a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Caleb,

On 29/09/2023 18:16, Caleb Connolly wrote:
> The Thermal Mitigation Device (TMD) service exposes various platform
> specific thermal mitigations available on remote subsystems (ie the
> modem, adsp, cdsp, and sdsp). The service is exposed via the QMI messaging
> interface, usually over the QRTR transport.
> 
> These controls affect things like the power limits of the modem power
> amplifier and cpu core, skin temperature mitigations, as well as rail
> voltage restrictions under cold conditions.
As it is a new driver, is it possible to elaborate a bit more the 
description of this driver. For instance, why there are notifications 
from the server, what is 'new server', how can happen 'del server' ? 
etc... That will help in the future to maintain the driver.


> Each remote subsystem has its own TMD instance, where each child node
> represents a single thermal control.

The QMI TMD driver is not a cooling device from a formal thermal 
framework semantic point of view. Like the cpufreq drivers are not.

However they fall under the semantic of thermal mitigation devices which 
is relatively new (eg. they can warm up).

 From a design point view, it sounds more adequate to have the same 
approach as the other passive cooling device, especially that this 
device may be used in the future by other subsystems (AFAIU).

I suggest to remove everything related to the cooling device and keep 
the driver specific bits. For instance this driver name should what it 
is, qmi-tmd and not qmi-cooling. And give simple interfaces to act on 
it. Moreover, this interface would have to sort out 'cooling' and 
'warming' effects vs the specified state.

As asked in a previous email about a performance / power QoS. IMO it 
would be more consistent to have a 'performance_cooling_device' based on 
a performance QoS as we have a cpufreq_cooling_device based on freq_qos 
and a devfreq_cooling_device based on a dev_freq_qos.

More comments below (but cooling related code skipped). Overall the 
variable names for the message are too long, even it is the sake of self 
explanatory names, that does not help actually. It would be more easy to 
read shorted variable but with a comment describing their purposes.

> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/thermal/qcom/Kconfig       |  13 +
>   drivers/thermal/qcom/Makefile      |   1 +
>   drivers/thermal/qcom/qmi-cooling.c | 520 +++++++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/qmi-cooling.h | 428 ++++++++++++++++++++++++++++++
>   4 files changed, 962 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 2c7f3f9a26eb..a24c840b78b3 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -41,3 +41,16 @@ config QCOM_LMH
>   	  input from temperature and current sensors.  On many newer Qualcomm SoCs
>   	  LMh is configured in the firmware and this feature need not be enabled.
>   	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
> +
> +config QCOM_QMI_COOLING
> +	tristate "Qualcomm QMI cooling drivers"
> +	depends on QCOM_RPROC_COMMON
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_QMI_HELPERS
> +	help
> +	   This enables the remote subsystem cooling devices. These cooling
> +	   devices will be used by Qualcomm chipset to place various remote
> +	   subsystem mitigations like remote processor passive mitigation,
> +	   remote subsystem voltage restriction at low temperatures etc.
> +	   The QMI cooling device will interface with remote subsystem
> +	   using Qualcomm remoteproc interface.
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 0fa2512042e7..94dd98e89af9 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -6,3 +6,4 @@ qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>   obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
>   obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>   obj-$(CONFIG_QCOM_LMH)		+= lmh.o
> +obj-$(CONFIG_QCOM_QMI_COOLING) += qmi-cooling.o
> diff --git a/drivers/thermal/qcom/qmi-cooling.c b/drivers/thermal/qcom/qmi-cooling.c
> new file mode 100644
> index 000000000000..c34fecd7eefa
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi-cooling.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017, The Linux Foundation
> + * Copyright (c) 2023, Linaro Limited
> + *
> + * QMI Thermal Mitigation Device (TMD) client driver.
> + * This driver provides an in-kernel client to handle hot and cold thermal
> + * mitigations for remote subsystems (modem and DSPs) running the TMD service.
> + * It doesn't implement any handling of reports from remote subsystems.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/net.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc/qcom_rproc.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/thermal.h>
> +
> +#include "qmi-cooling.h"
> +
> +#define MODEM0_INSTANCE_ID	0x0
> +#define ADSP_INSTANCE_ID	0x1
> +#define CDSP_INSTANCE_ID	0x43
> +#define SLPI_INSTANCE_ID	0x53
> +
> +#define QMI_TMD_RESP_TIMEOUT msecs_to_jiffies(100)
> +
> +/**
> + * struct qmi_instance_id - QMI instance ID and name
> + * @id:		The QMI instance ID
> + * @name:	Friendly name for this instance
> + */
> +struct qmi_instance_id {
> +	u32 id;
> +	const char *name;
> +};
> +
> +/**
> + * struct qmi_tmd_client - TMD client state
> + * @dev:	Device associated with this client
> + * @name:	Friendly name for the remote TMD service
> + * @handle:	QMI connection handle
> + * @mutex:	Lock to synchronise QMI communication
> + * @id:		The QMI TMD service instance ID
> + * @cdev_list:	The list of cooling devices (controls) enabled for this instance
> + * @svc_arrive_work: Work item for initialising the client when the TMD service
> + *		     starts.
> + * @connection_active: Whether or not we're connected to the QMI TMD service
> + */
> +struct qmi_tmd_client {
> +	struct device *dev;
> +	const char *name;

dev, name and id are basically used to write information in the logs. 
Those logs are too numerous in this driver and most of them can go away.

The remaining places where these fields are needed can be replaced by 
local variables.

> +	struct qmi_handle handle;
> +	struct mutex mutex;
> +	u32 id;
> +	struct list_head cdev_list;
> +	struct work_struct svc_arrive_work;
> +	bool connection_active;
> +};
> +
> +/**
> + * struct qmi_tmd - A TMD cooling device
> + * @np:		OF node associated with this control
> + * @type:	The control type (exposed via sysfs)
> + * @qmi_name:	The common name of this control shared by the remote subsystem
> + * @cdev:	Thermal framework cooling device handle
> + * @cur_state:	The current cooling/warming/mitigation state
> + * @max_state:	The maximum state
> + * @client:	The TMD client instance this control is associated with
> + */
> +struct qmi_tmd {
> +	struct device_node *np;

This reference should not be needed.

> +	const char *type;

Also, that is duplicate information, it should not be needed.

> +	char qmi_name[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];

kstrdup on char *name;

(and this field is already in the qmi_tmd namespace so putting 
*qmi*_name is duplicate information)

> +	struct list_head node;
> +	struct thermal_cooling_device *cdev;
> +	unsigned int cur_state;
> +	unsigned int max_state;
> +	struct qmi_tmd_client *client;
> +};
> +
> +/* Notify the remote subsystem of the requested cooling state */
> +static int qmi_tmd_send_state_request(struct qmi_tmd *tmd)
> +{
> +	struct tmd_set_mitigation_level_resp_msg_v01 tmd_resp;
> +	struct tmd_set_mitigation_level_req_msg_v01 req;

The structure names are a bit long, we may want to shortened them somehow.

> +	struct qmi_tmd_client *client;
> +	struct qmi_txn txn;
> +	int ret = 0;
> +
> +	client = tmd->client;
> +
> +	if (!client->connection_active)
> +		return 0;

	return -ENOTCONN; ?

> +
> +	memset(&req, 0, sizeof(req));
> +	memset(&tmd_resp, 0, sizeof(tmd_resp));

As previously said:

	tmd_resp = { 0 };
	reg = { 0 };

at declaration time

> +	strscpy(req.mitigation_dev_id.mitigation_dev_id, tmd->qmi_name,
> +		QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);

Variables name too, nested names too long. It is difficult to read.

> +	req.mitigation_level = tmd->cur_state;

What would it be for 'warming' device ?

> +	mutex_lock(&client->mutex);
> +
> +	ret = qmi_txn_init(&client->handle, &txn,
> +			   tmd_set_mitigation_level_resp_msg_v01_ei, &tmd_resp);

Too loong :)

Having a nice description in the comment when declaring a shortened 
tmd_set_mitigation_level_resp_msg_v01_ei variable name should be more 
adequate.

> +	if (ret < 0) {
> +		dev_err(client->dev, "qmi set state %d txn init failed for %s ret %d\n",
> +			tmd->cur_state, tmd->type, ret);

No need to write an error message. Return is enough.

> +		goto qmi_send_exit;
> +	}
> +
> +	ret = qmi_send_request(&client->handle, NULL, &txn,
> +			       QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01,
> +			       TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN,
> +			       tmd_set_mitigation_level_req_msg_v01_ei, &req);
> +	if (ret < 0) {
> +		dev_err(client->dev, "qmi set state %d txn send failed for %s ret %d\n",
> +			tmd->cur_state, tmd->type, ret);

No need to write an error message

> +		qmi_txn_cancel(&txn);
> +		goto qmi_send_exit;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(client->dev, "qmi set state %d txn wait failed for %s ret %d\n",
> +			tmd->cur_state, tmd->type, ret);

No need to write an error message

> +		goto qmi_send_exit;
> +	}
> +	ret = 0;

Usually, ret = 0 is just before the exit label

> +
> +	if (tmd_resp.resp.result != QMI_RESULT_SUCCESS_V01) {
> +		ret = tmd_resp.resp.result;

Is the result an errno ?

> +		dev_err(client->dev, "qmi set state %d NOT success for %s ret %d\n",
> +			tmd->cur_state, tmd->type, ret);

No need to write an error message

> +		goto qmi_send_exit;
> +	}
> +
> +	dev_dbg(client->dev, "Requested state %d/%d for %s\n", tmd->cur_state,
> +		tmd->max_state, tmd->type);

No need to write this debug message

> +
> +qmi_send_exit:
> +	mutex_unlock(&client->mutex);
> +	return ret;
> +}
> +

[ ... ]

> +/*
> + * Init a single TMD control by registering a cooling device for it, or
> + * synchronising state with the remote subsystem if recovering from a service
> + * restart. This is called when the TMD service starts up.
> + */
> +static int qmi_tmd_init_control(struct qmi_tmd_client *client, const char *label,
> +				u8 max_state)
> +{
> +	struct qmi_tmd *tmd = NULL;

Initialization not useful

> +	list_for_each_entry(tmd, &client->cdev_list, node)
> +		if (!strncasecmp(tmd->qmi_name, label,
> +				 QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1))
> +			goto found;

Invert the logic:

		if (strncasecmp(...))
			continue;

		if (tmd->cdev)
			return qmi_tmd_send_state_request(tmd);

		/* return 0 */
	}
> +
> +	dev_dbg(client->dev,
> +		"TMD '%s' available in firmware but not specified in DT\n",
> +		label);

No need to write this debug message

> +	return 0;
> +
> +found:
> +	tmd->max_state = max_state;
> +	/*
> +	 * If the cooling device already exists then the QMI service went away and
> +	 * came back. So just make sure the current cooling device state is
> +	 * reflected on the remote side and then return.
> +	 */
> +	if (tmd->cdev)
> +		return qmi_tmd_send_state_request(tmd);
> +
> +	return qmi_register_cooling_device(tmd);
> +}
> +
> +/*
> + * When the QMI service starts up on a remote subsystem this function will fetch
> + * the list of TMDs on the subsystem, match it to the TMDs specified in devicetree
> + * and call qmi_tmd_init_control() for each
> + */
> +static void qmi_tmd_svc_arrive(struct work_struct *work)
> +{
> +	struct qmi_tmd_client *client =
> +		container_of(work, struct qmi_tmd_client, svc_arrive_work);
> +
> +	struct tmd_get_mitigation_device_list_req_msg_v01 req;
> +	struct tmd_get_mitigation_device_list_resp_msg_v01 *resp;
> +	int ret = 0, i;
> +	struct qmi_txn txn;
> +
> +	memset(&req, 0, sizeof(req));
> +	/* resp struct is 1.1kB, allocate it on the heap. */
> +	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
> +	if (!resp)
> +		return;
> +
> +	/* Get a list of TMDs supported by the remoteproc */
> +	mutex_lock(&client->mutex);
> +	ret = qmi_txn_init(&client->handle, &txn,
> +			   tmd_get_mitigation_device_list_resp_msg_v01_ei, resp);
> +	if (ret < 0) {
> +		dev_err(client->dev,
> +			"Transaction init error for instance_id: %#x ret %d\n",
> +			client->id, ret);

No need to write an error message, qmi_txn_init() writes one

> +		goto reg_exit;
> +	}
> +
> +	ret = qmi_send_request(&client->handle, NULL, &txn,
> +			       QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01,
> +			       TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN,
> +			       tmd_get_mitigation_device_list_req_msg_v01_ei, &req);
> +	if (ret < 0) {
> +		qmi_txn_cancel(&txn);
> +		goto reg_exit;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(client->dev, "Transaction wait error for client %#x ret:%d\n",
> +			client->id, ret);

No need to write an error message

> +		goto reg_exit;
> +	}
> +	if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
> +		ret = resp->resp.result;
> +		dev_err(client->dev, "Failed to get device list for client %#x ret:%d\n",
> +			client->id, ret);

No need to write an error message

> +		goto reg_exit;
> +	}
> +	mutex_unlock(&client->mutex);
> +
> +	client->connection_active = true;
> +
> +	for (i = 0; i < resp->mitigation_device_list_len; i++) {
> +		struct tmd_mitigation_dev_list_type_v01 *device =
> +			&resp->mitigation_device_list[i];
> +
> +		ret = qmi_tmd_init_control(client,
> +					   device->mitigation_dev_id.mitigation_dev_id,
> +					   device->max_mitigation_level);
> +		if (ret)
> +			break;
> +	}
> +
> +	kfree(resp);
> +	return;
> +
> +reg_exit:
> +	mutex_unlock(&client->mutex);
> +	kfree(resp);
> +}
> +
> +static void thermal_qmi_net_reset(struct qmi_handle *qmi)
> +{
> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
> +	struct qmi_tmd *tmd = NULL;
> +
> +	pr_info("QMI TMD service reset %s\n", client->name);

This message is not needed

> +
> +	list_for_each_entry(tmd, &client->cdev_list, node) {
> +		qmi_tmd_send_state_request(tmd);
> +	}
> +}
> +
> +static void thermal_qmi_del_server(struct qmi_handle *qmi, struct qmi_service *service)
> +{
> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
> +
> +	pr_info("QMI TMD service stop %s\n", client->name);

This message is not needed

> +
> +	client->connection_active = false;
> +}
> +
> +static int thermal_qmi_new_server(struct qmi_handle *qmi, struct qmi_service *service)
> +{
> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
> +	struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node, service->port };
> +
> +	pr_info("QMI TMD service start %s\n", client->name);

This message is not needed

> +	mutex_lock(&client->mutex);
> +	kernel_connect(qmi->sock, (struct sockaddr *)&sq, sizeof(sq), 0);

error code ?

> +	mutex_unlock(&client->mutex);
> +	queue_work(system_highpri_wq, &client->svc_arrive_work);
> +
> +	return 0;
> +}
> +
> +static struct qmi_ops thermal_qmi_event_ops = {
> +	.new_server = thermal_qmi_new_server,
> +	.del_server = thermal_qmi_del_server,
> +	.net_reset = thermal_qmi_net_reset,
> +};
> +
> +static void qmi_tmd_cleanup(struct qmi_tmd_client *client)
> +{
> +	struct qmi_tmd *tmd, *c_next;
> +
> +	client->connection_active = false;
> +
> +	mutex_lock(&client->mutex);
> +	qmi_handle_release(&client->handle);
> +	cancel_work(&client->svc_arrive_work);
> +	list_for_each_entry_safe(tmd, c_next, &client->cdev_list, node) {
> +		if (tmd->cdev)
> +			thermal_cooling_device_unregister(tmd->cdev);
> +
> +		list_del(&tmd->node);
> +	}
> +	mutex_unlock(&client->mutex);
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

No error display with memory allocation

> +
> +		tmd->type = devm_kasprintf(client->dev, GFP_KERNEL, "%s:%s",
> +						client->name, subnode->name);
> +		if (!tmd->type)
> +			return dev_err_probe(dev, -ENOMEM, "Cooling device name\n");
> +
> +		if (of_property_read_string(subnode, "label", &name)) {
> +			return dev_err_probe(client->dev, -EINVAL,
> +					     "Fail to parse dev name for %s\n",
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

Stricto sensu, they are not cooling devices. They are mitigation devices.

> +
> +	return 0;
> +}
> +
> +static int qmi_tmd_client_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct qmi_tmd_client *client;
> +	const struct qmi_instance_id *match;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +
> +	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	client->dev = dev;
> +	match = of_device_get_match_data(dev);
> +	if (!match)
> +		return dev_err_probe(dev, -EINVAL, "No match data\n");
> +
> +	client->id = match->id;
> +	client->name = match->name;

See the comment at the beginning of the code about the client structure 
definition.
  +
> +	mutex_init(&client->mutex);
> +	INIT_LIST_HEAD(&client->cdev_list);
> +	INIT_WORK(&client->svc_arrive_work, qmi_tmd_svc_arrive);
> +
> +	ret = qmi_tmd_alloc_cdevs(client);
> +	if (ret)
> +		return ret;

It is cumbersome to assign client->dev and then reuse it as a devm 
resource in the qmi_tmd_alloc_cdevs. I suggest to pass 'dev' to the 
function and rename it to dev_qmi_tmd_alloc(dev, ...), so it is clear 
for the reader the function is supposed to rely on the devm_ cleanup 
mechanism for the client.

> +
> +	platform_set_drvdata(pdev, client);
> +
> +	ret = qmi_handle_init(&client->handle,
> +			      TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN,
> +			      &thermal_qmi_event_ops, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(client->dev, ret, "QMI handle init failed for client %#x\n",
> +			      client->id);

What are those notifications?

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
> +static int qmi_tmd_client_remove(struct platform_device *pdev)
> +{
> +	struct qmi_tmd_client *client = platform_get_drvdata(pdev);
> +
> +	qmi_tmd_cleanup(client);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qmi_tmd_device_table[] = {
> +	{
> +		.compatible = "qcom,qmi-cooling-modem",
> +		.data = &((struct qmi_instance_id) { MODEM0_INSTANCE_ID, "modem" }),
> +	}, {
> +		.compatible = "qcom,qmi-cooling-adsp",
> +		.data = &((struct qmi_instance_id) { ADSP_INSTANCE_ID, "adsp" }),
> +	}, {
> +		.compatible = "qcom,qmi-cooling-cdsp",
> +		.data = &((struct qmi_instance_id) { CDSP_INSTANCE_ID, "cdsp" }),
> +	}, {
> +		.compatible = "qcom,qmi-cooling-slpi",
> +		.data = &((struct qmi_instance_id) { SLPI_INSTANCE_ID, "slpi" }),
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qmi_tmd_device_table);
> +
> +static struct platform_driver qmi_tmd_device_driver = {
> +	.probe          = qmi_tmd_client_probe,
> +	.remove         = qmi_tmd_client_remove,
> +	.driver         = {
> +		.name   = "qcom-qmi-cooling",
> +		.of_match_table = qmi_tmd_device_table,
> +	},
> +};
> +
> +module_platform_driver(qmi_tmd_device_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm QMI Thermal Mitigation Device driver");
> diff --git a/drivers/thermal/qcom/qmi-cooling.h b/drivers/thermal/qcom/qmi-cooling.h
> new file mode 100644
> index 000000000000..f46b827b4ce6
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi-cooling.h
> @@ -0,0 +1,428 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2017, The Linux Foundation
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef __QCOM_COOLING_H__
> +#define __QCOM_COOLING_H__
> +
> +#include <linux/soc/qcom/qmi.h>
> +
> +#define TMD_SERVICE_ID_V01 0x18
> +#define TMD_SERVICE_VERS_V01 0x01
> +
> +#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_RESP_V01 0x0020
> +#define QMI_TMD_GET_MITIGATION_LEVEL_REQ_V01 0x0022
> +#define QMI_TMD_GET_SUPPORTED_MSGS_REQ_V01 0x001E
> +#define QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01 0x0021
> +#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01 0x0023
> +#define QMI_TMD_GET_SUPPORTED_MSGS_RESP_V01 0x001E
> +#define QMI_TMD_SET_MITIGATION_LEVEL_RESP_V01 0x0021
> +#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01 0x0024
> +#define QMI_TMD_MITIGATION_LEVEL_REPORT_IND_V01 0x0025
> +#define QMI_TMD_GET_MITIGATION_LEVEL_RESP_V01 0x0022
> +#define QMI_TMD_GET_SUPPORTED_FIELDS_REQ_V01 0x001F
> +#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01 0x0020
> +#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01 0x0023
> +#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01 0x0024
> +#define QMI_TMD_GET_SUPPORTED_FIELDS_RESP_V01 0x001F

What is the purpose of this header ?

The content is not shared and apparently lot is unused in the .c code.

> +#define QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 32
> +#define QMI_TMD_MITIGATION_DEV_LIST_MAX_V01 32
> +
> +struct tmd_mitigation_dev_id_type_v01 {
> +	char mitigation_dev_id[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];
> +};
> +
> +static const struct qmi_elem_info tmd_mitigation_dev_id_type_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRING,
> +		.elem_len = QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1,
> +		.elem_size = sizeof(char),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0,
> +		.offset = offsetof(struct tmd_mitigation_dev_id_type_v01,
> +				   mitigation_dev_id),
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_mitigation_dev_list_type_v01 {
> +	struct tmd_mitigation_dev_id_type_v01 mitigation_dev_id;
> +	uint8_t max_mitigation_level;
> +};
> +
> +static const struct qmi_elem_info tmd_mitigation_dev_list_type_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0,
> +		.offset = offsetof(struct tmd_mitigation_dev_list_type_v01,
> +				   mitigation_dev_id),
> +		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_UNSIGNED_1_BYTE,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0,
> +		.offset = offsetof(struct tmd_mitigation_dev_list_type_v01,
> +				   max_mitigation_level),
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_get_mitigation_device_list_req_msg_v01 {
> +	char placeholder;
> +};
> +
> +#define TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN 0
> +const struct qmi_elem_info tmd_get_mitigation_device_list_req_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_get_mitigation_device_list_resp_msg_v01 {
> +	struct qmi_response_type_v01 resp;
> +	uint8_t mitigation_device_list_valid;
> +	uint32_t mitigation_device_list_len;
> +	struct tmd_mitigation_dev_list_type_v01
> +		mitigation_device_list[QMI_TMD_MITIGATION_DEV_LIST_MAX_V01];
> +};
> +
> +#define TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN 1099
> +static const struct qmi_elem_info tmd_get_mitigation_device_list_resp_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct qmi_response_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x02,
> +		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
> +				   resp),
> +		.ei_array = qmi_response_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_OPT_FLAG,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x10,
> +		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
> +				   mitigation_device_list_valid),
> +	},
> +	{
> +		.data_type = QMI_DATA_LEN,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x10,
> +		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
> +				   mitigation_device_list_len),
> +	},
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = QMI_TMD_MITIGATION_DEV_LIST_MAX_V01,
> +		.elem_size = sizeof(struct tmd_mitigation_dev_list_type_v01),
> +		.array_type = VAR_LEN_ARRAY,
> +		.tlv_type = 0x10,
> +		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
> +				   mitigation_device_list),
> +		.ei_array = tmd_mitigation_dev_list_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_set_mitigation_level_req_msg_v01 {
> +	struct tmd_mitigation_dev_id_type_v01 mitigation_dev_id;
> +	uint8_t mitigation_level;
> +};
> +
> +#define TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 40
> +static const struct qmi_elem_info tmd_set_mitigation_level_req_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x01,
> +		.offset = offsetof(struct tmd_set_mitigation_level_req_msg_v01,
> +				   mitigation_dev_id),
> +		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_UNSIGNED_1_BYTE,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x02,
> +		.offset = offsetof(struct tmd_set_mitigation_level_req_msg_v01,
> +				   mitigation_level),
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_set_mitigation_level_resp_msg_v01 {
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +#define TMD_SET_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 7
> +static const struct qmi_elem_info tmd_set_mitigation_level_resp_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct qmi_response_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x02,
> +		.offset = offsetof(struct tmd_set_mitigation_level_resp_msg_v01, resp),
> +		.ei_array = qmi_response_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_get_mitigation_level_req_msg_v01 {
> +	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
> +};
> +#define TMD_GET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 36
> +
> +static const struct qmi_elem_info tmd_get_mitigation_level_req_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x01,
> +		.offset = offsetof(struct tmd_get_mitigation_level_req_msg_v01,
> +				   mitigation_device),
> +		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_get_mitigation_level_resp_msg_v01 {
> +	struct qmi_response_type_v01 resp;
> +	uint8_t current_mitigation_level_valid;
> +	uint8_t current_mitigation_level;
> +	uint8_t requested_mitigation_level_valid;
> +	uint8_t requested_mitigation_level;
> +};
> +
> +#define TMD_GET_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 15
> +static const struct qmi_elem_info tmd_get_mitigation_level_resp_msg_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct qmi_response_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x02,
> +		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01, resp),
> +		.ei_array = qmi_response_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_OPT_FLAG,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x10,
> +		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
> +				   current_mitigation_level_valid),
> +	},
> +	{
> +		.data_type = QMI_UNSIGNED_1_BYTE,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x10,
> +		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
> +				   current_mitigation_level),
> +	},
> +	{
> +		.data_type = QMI_OPT_FLAG,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x11,
> +		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
> +				   requested_mitigation_level_valid),
> +	},
> +	{
> +		.data_type = QMI_UNSIGNED_1_BYTE,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x11,
> +		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
> +				   requested_mitigation_level),
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +struct tmd_register_notification_mitigation_level_req_msg_v01 {
> +	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
> +};
> +
> +#define TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 36
> +static const struct qmi_elem_info
> +	tmd_register_notification_mitigation_level_req_msg_v01_ei[] = {
> +		{
> +			.data_type = QMI_STRUCT,
> +			.elem_len = 1,
> +			.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
> +			.array_type = NO_ARRAY,
> +			.tlv_type = 0x01,
> +			.offset = offsetof(
> +				struct tmd_register_notification_mitigation_level_req_msg_v01,
> +				mitigation_device),
> +			.ei_array = tmd_mitigation_dev_id_type_v01_ei,
> +		},
> +		{
> +			.data_type = QMI_EOTI,
> +			.array_type = NO_ARRAY,
> +			.tlv_type = QMI_COMMON_TLV_TYPE,
> +		},
> +	};
> +
> +struct tmd_register_notification_mitigation_level_resp_msg_v01 {
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +#define TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 7
> +static const struct qmi_elem_info
> +	tmd_register_notification_mitigation_level_resp_msg_v01_ei[] = {
> +		{
> +			.data_type = QMI_STRUCT,
> +			.elem_len = 1,
> +			.elem_size = sizeof(struct qmi_response_type_v01),
> +			.array_type = NO_ARRAY,
> +			.tlv_type = 0x02,
> +			.offset = offsetof(
> +				struct tmd_register_notification_mitigation_level_resp_msg_v01,
> +				resp),
> +			.ei_array = qmi_response_type_v01_ei,
> +		},
> +		{
> +			.data_type = QMI_EOTI,
> +			.array_type = NO_ARRAY,
> +			.tlv_type = QMI_COMMON_TLV_TYPE,
> +		},
> +	};
> +
> +struct tmd_deregister_notification_mitigation_level_req_msg_v01 {
> +	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
> +};
> +
> +#define TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 36
> +static const struct qmi_elem_info
> +	tmd_deregister_notification_mitigation_level_req_msg_v01_ei[] = {

Not used

> +		{
> +			.data_type = QMI_STRUCT,
> +			.elem_len = 1,
> +			.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
> +			.array_type = NO_ARRAY,
> +			.tlv_type = 0x01,
> +			.offset = offsetof(
> +				struct tmd_deregister_notification_mitigation_level_req_msg_v01,
> +				mitigation_device),
> +			.ei_array = tmd_mitigation_dev_id_type_v01_ei,
> +		},
> +		{
> +			.data_type = QMI_EOTI,
> +			.array_type = NO_ARRAY,
> +			.tlv_type = QMI_COMMON_TLV_TYPE,
> +		},
> +	};
> +
> +struct tmd_deregister_notification_mitigation_level_resp_msg_v01 {
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +#define TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 7
> +static const struct qmi_elem_info
> +	tmd_deregister_notification_mitigation_level_resp_msg_v01_ei[] = {

Not used

> +		{
> +			.data_type = QMI_STRUCT,
> +			.elem_len = 1,
> +			.elem_size = sizeof(struct qmi_response_type_v01),
> +			.array_type = NO_ARRAY,
> +			.tlv_type = 0x02,
> +			.offset = offsetof(
> +				struct tmd_deregister_notification_mitigation_level_resp_msg_v01,
> +				resp),
> +			.ei_array = qmi_response_type_v01_ei,
> +		},
> +		{
> +			.data_type = QMI_EOTI,
> +			.array_type = NO_ARRAY,
> +			.tlv_type = QMI_COMMON_TLV_TYPE,
> +		},
> +	};
> +
> +struct tmd_mitigation_level_report_ind_msg_v01 {
> +	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
> +	uint8_t current_mitigation_level;
> +};

Not used the structure below is not used too.

> +
> +#define TMD_MITIGATION_LEVEL_REPORT_IND_MSG_V01_MAX_MSG_LEN 40

Where is it used?

> +static const struct qmi_elem_info tmd_mitigation_level_report_ind_msg_v01_ei[] = {

I don't see this variable used.

> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x01,
> +		.offset = offsetof(struct tmd_mitigation_level_report_ind_msg_v01,
> +				   mitigation_device),
> +		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_UNSIGNED_1_BYTE,
> +		.elem_len = 1,
> +		.elem_size = sizeof(uint8_t),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x02,
> +		.offset = offsetof(struct tmd_mitigation_level_report_ind_msg_v01,
> +				   current_mitigation_level),
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.array_type = NO_ARRAY,
> +		.tlv_type = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +#endif /* __QMI_COOLING_INTERNAL_H__ */
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

