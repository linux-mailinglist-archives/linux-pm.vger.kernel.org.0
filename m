Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E37B37AB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjI2QQ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2QQ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 12:16:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9A1A4
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 09:16:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3247cefa13aso3762914f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696004210; x=1696609010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAD+9fgOewzIf7ZP+QAXaMMzR/LebP7x+Ep4NonP0kY=;
        b=Z63/ShuU1Dw6pVKxmzqk5C8T7nogTUL6ZscUKAUkcGttu69x8aaHhxntgE7Qm74oAU
         oaZvTzOIsVyQMBjs1oH65xrvzV0mny2/fwzzWkNhh+e/w9TvWIKWwssILMtb4yiOZzV6
         RexDw1nwjqNv8uP7WWi+4q/2h6GZpRxpMnRTzVYwR2pJRAmILKD69/vfUX5lHjNAGMMy
         cDpbCeyzF3wtp2fLgeCG9XWiuDiBMrpINBmrZ7ciJe3rPDHW81e1tt69DqBuPeYJ9nBG
         MCuHr2zTIlbd1ByUrMTVAm8+LqNX5/wrKXNQhlpn0EwnGKIRUjIJ6NEh47Y5YaVpfSJc
         zAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004210; x=1696609010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAD+9fgOewzIf7ZP+QAXaMMzR/LebP7x+Ep4NonP0kY=;
        b=rd6EpZhRaea/bNkVoSUD68+qE2XOHUx/zIcih80wz5dat3c3UZYeiM0WyUjDiVy/uP
         pTVfwWB+S1wue5rjbrmKm8At/khVClJs0ouxaoL5bFNZRX8T6jAnbws4ws9w9umnFcMS
         vsH2DHLd3ChssOqTUpWM2NVho92P5GGpXeQzc59CXhoi2y6SeCTRSd8LzN3DvORFXA/M
         vj75EIS3O0f/xNQBpRHf7uuc5FV9/UcUTRMhorBsAVhjjQV193jLjJsTTnFEYSith2vc
         ktzozv5mEOjZALKL3GbM5liLv9Lxm7DkN651Ci3o8CCcugxCJWnKY/Y4gSwZ+2nFjujh
         6dng==
X-Gm-Message-State: AOJu0YycGHm8vJNJW/XJkPF2PeJLv7SI1E6AaFR3sw5dcClrUSQg+RR1
        nbbhdpJQe8iobhBq4el7jGmweg==
X-Google-Smtp-Source: AGHT+IEZWXJ7Z9wcwcGMCd47rencwdVqmsnHPvnPJDx+wgryiTMyh5g+SWbOJSPN2DJJGdFcLJzTOQ==
X-Received: by 2002:a05:6000:104a:b0:320:4d1:d5f3 with SMTP id c10-20020a056000104a00b0032004d1d5f3mr3850757wrx.6.1696004210370;
        Fri, 29 Sep 2023 09:16:50 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id x15-20020adfcc0f000000b0032330e43590sm10226848wrh.22.2023.09.29.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:16:50 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
Date:   Fri, 29 Sep 2023 17:16:19 +0100
Subject: [PATCH 3/4] thermal: qcom: add qmi-cooling driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-caleb-qmi_cooling-v1-3-5aa39d4164a7@linaro.org>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
In-Reply-To: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=31160;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=NqLX3dSARWdv7LCXW7mE06ZV7C96Ez5s2Y6HIdvJnoE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlSxH3lLb5w6JTyj5vWvmqemtltM0joMD/0SdeBj0DL+U
 rS4/VNtRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI1z0M/8M8pWY3bN73Wvv1
 tx8hj1kNgjoEBLqXJH2r7VSqfJkT8YPhN0vQRb2Dsz76iCqqPfq43HRlbNeT7z7uqZtnL934d9L
 Mrn4A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Thermal Mitigation Device (TMD) service exposes various platform
specific thermal mitigations available on remote subsystems (ie the
modem, adsp, cdsp, and sdsp). The service is exposed via the QMI messaging
interface, usually over the QRTR transport.

These controls affect things like the power limits of the modem power
amplifier and cpu core, skin temperature mitigations, as well as rail
voltage restrictions under cold conditions.

Each remote subsystem has its own TMD instance, where each child node
represents a single thermal control.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/thermal/qcom/Kconfig       |  13 +
 drivers/thermal/qcom/Makefile      |   1 +
 drivers/thermal/qcom/qmi-cooling.c | 520 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/qmi-cooling.h | 428 ++++++++++++++++++++++++++++++
 4 files changed, 962 insertions(+)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26eb..a24c840b78b3 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -41,3 +41,16 @@ config QCOM_LMH
 	  input from temperature and current sensors.  On many newer Qualcomm SoCs
 	  LMh is configured in the firmware and this feature need not be enabled.
 	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
+
+config QCOM_QMI_COOLING
+	tristate "Qualcomm QMI cooling drivers"
+	depends on QCOM_RPROC_COMMON
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_QMI_HELPERS
+	help
+	   This enables the remote subsystem cooling devices. These cooling
+	   devices will be used by Qualcomm chipset to place various remote
+	   subsystem mitigations like remote processor passive mitigation,
+	   remote subsystem voltage restriction at low temperatures etc.
+	   The QMI cooling device will interface with remote subsystem
+	   using Qualcomm remoteproc interface.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 0fa2512042e7..94dd98e89af9 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -6,3 +6,4 @@ qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_QCOM_LMH)		+= lmh.o
+obj-$(CONFIG_QCOM_QMI_COOLING) += qmi-cooling.o
diff --git a/drivers/thermal/qcom/qmi-cooling.c b/drivers/thermal/qcom/qmi-cooling.c
new file mode 100644
index 000000000000..c34fecd7eefa
--- /dev/null
+++ b/drivers/thermal/qcom/qmi-cooling.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, The Linux Foundation
+ * Copyright (c) 2023, Linaro Limited
+ *
+ * QMI Thermal Mitigation Device (TMD) client driver.
+ * This driver provides an in-kernel client to handle hot and cold thermal
+ * mitigations for remote subsystems (modem and DSPs) running the TMD service.
+ * It doesn't implement any handling of reports from remote subsystems.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc/qcom_rproc.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/thermal.h>
+
+#include "qmi-cooling.h"
+
+#define MODEM0_INSTANCE_ID	0x0
+#define ADSP_INSTANCE_ID	0x1
+#define CDSP_INSTANCE_ID	0x43
+#define SLPI_INSTANCE_ID	0x53
+
+#define QMI_TMD_RESP_TIMEOUT msecs_to_jiffies(100)
+
+/**
+ * struct qmi_instance_id - QMI instance ID and name
+ * @id:		The QMI instance ID
+ * @name:	Friendly name for this instance
+ */
+struct qmi_instance_id {
+	u32 id;
+	const char *name;
+};
+
+/**
+ * struct qmi_tmd_client - TMD client state
+ * @dev:	Device associated with this client
+ * @name:	Friendly name for the remote TMD service
+ * @handle:	QMI connection handle
+ * @mutex:	Lock to synchronise QMI communication
+ * @id:		The QMI TMD service instance ID
+ * @cdev_list:	The list of cooling devices (controls) enabled for this instance
+ * @svc_arrive_work: Work item for initialising the client when the TMD service
+ *		     starts.
+ * @connection_active: Whether or not we're connected to the QMI TMD service
+ */
+struct qmi_tmd_client {
+	struct device *dev;
+	const char *name;
+	struct qmi_handle handle;
+	struct mutex mutex;
+	u32 id;
+	struct list_head cdev_list;
+	struct work_struct svc_arrive_work;
+	bool connection_active;
+};
+
+/**
+ * struct qmi_tmd - A TMD cooling device
+ * @np:		OF node associated with this control
+ * @type:	The control type (exposed via sysfs)
+ * @qmi_name:	The common name of this control shared by the remote subsystem
+ * @cdev:	Thermal framework cooling device handle
+ * @cur_state:	The current cooling/warming/mitigation state
+ * @max_state:	The maximum state
+ * @client:	The TMD client instance this control is associated with
+ */
+struct qmi_tmd {
+	struct device_node *np;
+	const char *type;
+	char qmi_name[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];
+	struct list_head node;
+	struct thermal_cooling_device *cdev;
+	unsigned int cur_state;
+	unsigned int max_state;
+	struct qmi_tmd_client *client;
+};
+
+/* Notify the remote subsystem of the requested cooling state */
+static int qmi_tmd_send_state_request(struct qmi_tmd *tmd)
+{
+	struct tmd_set_mitigation_level_resp_msg_v01 tmd_resp;
+	struct tmd_set_mitigation_level_req_msg_v01 req;
+	struct qmi_tmd_client *client;
+	struct qmi_txn txn;
+	int ret = 0;
+
+	client = tmd->client;
+
+	if (!client->connection_active)
+		return 0;
+
+	memset(&req, 0, sizeof(req));
+	memset(&tmd_resp, 0, sizeof(tmd_resp));
+
+	strscpy(req.mitigation_dev_id.mitigation_dev_id, tmd->qmi_name,
+		QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
+	req.mitigation_level = tmd->cur_state;
+
+	mutex_lock(&client->mutex);
+
+	ret = qmi_txn_init(&client->handle, &txn,
+			   tmd_set_mitigation_level_resp_msg_v01_ei, &tmd_resp);
+	if (ret < 0) {
+		dev_err(client->dev, "qmi set state %d txn init failed for %s ret %d\n",
+			tmd->cur_state, tmd->type, ret);
+		goto qmi_send_exit;
+	}
+
+	ret = qmi_send_request(&client->handle, NULL, &txn,
+			       QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01,
+			       TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN,
+			       tmd_set_mitigation_level_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		dev_err(client->dev, "qmi set state %d txn send failed for %s ret %d\n",
+			tmd->cur_state, tmd->type, ret);
+		qmi_txn_cancel(&txn);
+		goto qmi_send_exit;
+	}
+
+	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
+	if (ret < 0) {
+		dev_err(client->dev, "qmi set state %d txn wait failed for %s ret %d\n",
+			tmd->cur_state, tmd->type, ret);
+		goto qmi_send_exit;
+	}
+	ret = 0;
+
+	if (tmd_resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ret = tmd_resp.resp.result;
+		dev_err(client->dev, "qmi set state %d NOT success for %s ret %d\n",
+			tmd->cur_state, tmd->type, ret);
+		goto qmi_send_exit;
+	}
+
+	dev_dbg(client->dev, "Requested state %d/%d for %s\n", tmd->cur_state,
+		tmd->max_state, tmd->type);
+
+qmi_send_exit:
+	mutex_unlock(&client->mutex);
+	return ret;
+}
+
+static int qmi_get_max_state(struct thermal_cooling_device *cdev, unsigned long *state)
+{
+	struct qmi_tmd *tmd = cdev->devdata;
+
+	if (!tmd)
+		return -EINVAL;
+
+	*state = tmd->max_state;
+
+	return 0;
+}
+
+static int qmi_get_cur_state(struct thermal_cooling_device *cdev, unsigned long *state)
+{
+	struct qmi_tmd *tmd = cdev->devdata;
+
+	if (!tmd)
+		return -EINVAL;
+
+	*state = tmd->cur_state;
+
+	return 0;
+}
+
+static int qmi_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
+{
+	struct qmi_tmd *tmd = cdev->devdata;
+
+	if (!tmd)
+		return -EINVAL;
+
+	if (state > tmd->max_state)
+		return -EINVAL;
+
+	if (tmd->cur_state == state)
+		return 0;
+
+	tmd->cur_state = state;
+
+	return qmi_tmd_send_state_request(tmd);
+}
+
+static struct thermal_cooling_device_ops qmi_device_ops = {
+	.get_max_state = qmi_get_max_state,
+	.get_cur_state = qmi_get_cur_state,
+	.set_cur_state = qmi_set_cur_state,
+};
+
+static int qmi_register_cooling_device(struct qmi_tmd *tmd)
+{
+	struct thermal_cooling_device *cdev;
+
+	cdev = thermal_of_cooling_device_register(tmd->np, tmd->type, tmd,
+						  &qmi_device_ops);
+
+	if (IS_ERR(cdev))
+		return dev_err_probe(tmd->client->dev, PTR_ERR(tmd->cdev),
+				     "Failed to register cooling device %s\n",
+				     tmd->qmi_name);
+
+	tmd->cdev = cdev;
+	return 0;
+}
+
+/*
+ * Init a single TMD control by registering a cooling device for it, or
+ * synchronising state with the remote subsystem if recovering from a service
+ * restart. This is called when the TMD service starts up.
+ */
+static int qmi_tmd_init_control(struct qmi_tmd_client *client, const char *label,
+				u8 max_state)
+{
+	struct qmi_tmd *tmd = NULL;
+
+	list_for_each_entry(tmd, &client->cdev_list, node)
+		if (!strncasecmp(tmd->qmi_name, label,
+				 QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1))
+			goto found;
+
+	dev_dbg(client->dev,
+		"TMD '%s' available in firmware but not specified in DT\n",
+		label);
+	return 0;
+
+found:
+	tmd->max_state = max_state;
+	/*
+	 * If the cooling device already exists then the QMI service went away and
+	 * came back. So just make sure the current cooling device state is
+	 * reflected on the remote side and then return.
+	 */
+	if (tmd->cdev)
+		return qmi_tmd_send_state_request(tmd);
+
+	return qmi_register_cooling_device(tmd);
+}
+
+/*
+ * When the QMI service starts up on a remote subsystem this function will fetch
+ * the list of TMDs on the subsystem, match it to the TMDs specified in devicetree
+ * and call qmi_tmd_init_control() for each
+ */
+static void qmi_tmd_svc_arrive(struct work_struct *work)
+{
+	struct qmi_tmd_client *client =
+		container_of(work, struct qmi_tmd_client, svc_arrive_work);
+
+	struct tmd_get_mitigation_device_list_req_msg_v01 req;
+	struct tmd_get_mitigation_device_list_resp_msg_v01 *resp;
+	int ret = 0, i;
+	struct qmi_txn txn;
+
+	memset(&req, 0, sizeof(req));
+	/* resp struct is 1.1kB, allocate it on the heap. */
+	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
+	if (!resp)
+		return;
+
+	/* Get a list of TMDs supported by the remoteproc */
+	mutex_lock(&client->mutex);
+	ret = qmi_txn_init(&client->handle, &txn,
+			   tmd_get_mitigation_device_list_resp_msg_v01_ei, resp);
+	if (ret < 0) {
+		dev_err(client->dev,
+			"Transaction init error for instance_id: %#x ret %d\n",
+			client->id, ret);
+		goto reg_exit;
+	}
+
+	ret = qmi_send_request(&client->handle, NULL, &txn,
+			       QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01,
+			       TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN,
+			       tmd_get_mitigation_device_list_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		goto reg_exit;
+	}
+
+	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
+	if (ret < 0) {
+		dev_err(client->dev, "Transaction wait error for client %#x ret:%d\n",
+			client->id, ret);
+		goto reg_exit;
+	}
+	if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
+		ret = resp->resp.result;
+		dev_err(client->dev, "Failed to get device list for client %#x ret:%d\n",
+			client->id, ret);
+		goto reg_exit;
+	}
+	mutex_unlock(&client->mutex);
+
+	client->connection_active = true;
+
+	for (i = 0; i < resp->mitigation_device_list_len; i++) {
+		struct tmd_mitigation_dev_list_type_v01 *device =
+			&resp->mitigation_device_list[i];
+
+		ret = qmi_tmd_init_control(client,
+					   device->mitigation_dev_id.mitigation_dev_id,
+					   device->max_mitigation_level);
+		if (ret)
+			break;
+	}
+
+	kfree(resp);
+	return;
+
+reg_exit:
+	mutex_unlock(&client->mutex);
+	kfree(resp);
+}
+
+static void thermal_qmi_net_reset(struct qmi_handle *qmi)
+{
+	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
+	struct qmi_tmd *tmd = NULL;
+
+	pr_info("QMI TMD service reset %s\n", client->name);
+
+	list_for_each_entry(tmd, &client->cdev_list, node) {
+		qmi_tmd_send_state_request(tmd);
+	}
+}
+
+static void thermal_qmi_del_server(struct qmi_handle *qmi, struct qmi_service *service)
+{
+	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
+
+	pr_info("QMI TMD service stop %s\n", client->name);
+
+	client->connection_active = false;
+}
+
+static int thermal_qmi_new_server(struct qmi_handle *qmi, struct qmi_service *service)
+{
+	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
+	struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node, service->port };
+
+	pr_info("QMI TMD service start %s\n", client->name);
+
+	mutex_lock(&client->mutex);
+	kernel_connect(qmi->sock, (struct sockaddr *)&sq, sizeof(sq), 0);
+	mutex_unlock(&client->mutex);
+	queue_work(system_highpri_wq, &client->svc_arrive_work);
+
+	return 0;
+}
+
+static struct qmi_ops thermal_qmi_event_ops = {
+	.new_server = thermal_qmi_new_server,
+	.del_server = thermal_qmi_del_server,
+	.net_reset = thermal_qmi_net_reset,
+};
+
+static void qmi_tmd_cleanup(struct qmi_tmd_client *client)
+{
+	struct qmi_tmd *tmd, *c_next;
+
+	client->connection_active = false;
+
+	mutex_lock(&client->mutex);
+	qmi_handle_release(&client->handle);
+	cancel_work(&client->svc_arrive_work);
+	list_for_each_entry_safe(tmd, c_next, &client->cdev_list, node) {
+		if (tmd->cdev)
+			thermal_cooling_device_unregister(tmd->cdev);
+
+		list_del(&tmd->node);
+	}
+	mutex_unlock(&client->mutex);
+}
+
+/* Parse the controls and allocate a qmi_tmd for each of them */
+static int qmi_tmd_alloc_cdevs(struct qmi_tmd_client *client)
+{
+	struct device *dev = client->dev;
+	struct qmi_tmd *tmd;
+	struct device_node *subnode, *node = dev->of_node;
+	int ret;
+
+	for_each_available_child_of_node(node, subnode) {
+		const char *name;
+
+		tmd = devm_kzalloc(dev, sizeof(*tmd), GFP_KERNEL);
+		if (!tmd)
+			return dev_err_probe(client->dev, -ENOMEM,
+					     "Couldn't allocate tmd\n");
+
+		tmd->type = devm_kasprintf(client->dev, GFP_KERNEL, "%s:%s",
+						client->name, subnode->name);
+		if (!tmd->type)
+			return dev_err_probe(dev, -ENOMEM, "Cooling device name\n");
+
+		if (of_property_read_string(subnode, "label", &name)) {
+			return dev_err_probe(client->dev, -EINVAL,
+					     "Fail to parse dev name for %s\n",
+					     subnode->name);
+		}
+
+		ret = strscpy(tmd->qmi_name, name,
+			      QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
+		if (ret == -E2BIG) {
+			return dev_err_probe(dev, -EINVAL, "TMD label %s is too long\n",
+					     name);
+		}
+
+		tmd->client = client;
+		tmd->np = subnode;
+		tmd->cur_state = 0;
+		list_add(&tmd->node, &client->cdev_list);
+	}
+
+	if (list_empty(&client->cdev_list))
+		return dev_err_probe(client->dev, -EINVAL,
+				     "No cooling devices specified for client %s (%#x)\n",
+				     client->name, client->id);
+
+	return 0;
+}
+
+static int qmi_tmd_client_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct qmi_tmd_client *client;
+	const struct qmi_instance_id *match;
+	int ret;
+
+	dev = &pdev->dev;
+
+	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->dev = dev;
+
+	match = of_device_get_match_data(dev);
+	if (!match)
+		return dev_err_probe(dev, -EINVAL, "No match data\n");
+
+	client->id = match->id;
+	client->name = match->name;
+
+	mutex_init(&client->mutex);
+	INIT_LIST_HEAD(&client->cdev_list);
+	INIT_WORK(&client->svc_arrive_work, qmi_tmd_svc_arrive);
+
+	ret = qmi_tmd_alloc_cdevs(client);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, client);
+
+	ret = qmi_handle_init(&client->handle,
+			      TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN,
+			      &thermal_qmi_event_ops, NULL);
+	if (ret < 0)
+		return dev_err_probe(client->dev, ret, "QMI handle init failed for client %#x\n",
+			      client->id);
+
+	ret = qmi_add_lookup(&client->handle, TMD_SERVICE_ID_V01, TMD_SERVICE_VERS_V01,
+			     client->id);
+	if (ret < 0) {
+		qmi_handle_release(&client->handle);
+		return dev_err_probe(client->dev, ret, "QMI register failed for client 0x%x\n",
+			      client->id);
+	}
+
+	return 0;
+}
+
+static int qmi_tmd_client_remove(struct platform_device *pdev)
+{
+	struct qmi_tmd_client *client = platform_get_drvdata(pdev);
+
+	qmi_tmd_cleanup(client);
+
+	return 0;
+}
+
+static const struct of_device_id qmi_tmd_device_table[] = {
+	{
+		.compatible = "qcom,qmi-cooling-modem",
+		.data = &((struct qmi_instance_id) { MODEM0_INSTANCE_ID, "modem" }),
+	}, {
+		.compatible = "qcom,qmi-cooling-adsp",
+		.data = &((struct qmi_instance_id) { ADSP_INSTANCE_ID, "adsp" }),
+	}, {
+		.compatible = "qcom,qmi-cooling-cdsp",
+		.data = &((struct qmi_instance_id) { CDSP_INSTANCE_ID, "cdsp" }),
+	}, {
+		.compatible = "qcom,qmi-cooling-slpi",
+		.data = &((struct qmi_instance_id) { SLPI_INSTANCE_ID, "slpi" }),
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qmi_tmd_device_table);
+
+static struct platform_driver qmi_tmd_device_driver = {
+	.probe          = qmi_tmd_client_probe,
+	.remove         = qmi_tmd_client_remove,
+	.driver         = {
+		.name   = "qcom-qmi-cooling",
+		.of_match_table = qmi_tmd_device_table,
+	},
+};
+
+module_platform_driver(qmi_tmd_device_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm QMI Thermal Mitigation Device driver");
diff --git a/drivers/thermal/qcom/qmi-cooling.h b/drivers/thermal/qcom/qmi-cooling.h
new file mode 100644
index 000000000000..f46b827b4ce6
--- /dev/null
+++ b/drivers/thermal/qcom/qmi-cooling.h
@@ -0,0 +1,428 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017, The Linux Foundation
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __QCOM_COOLING_H__
+#define __QCOM_COOLING_H__
+
+#include <linux/soc/qcom/qmi.h>
+
+#define TMD_SERVICE_ID_V01 0x18
+#define TMD_SERVICE_VERS_V01 0x01
+
+#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_RESP_V01 0x0020
+#define QMI_TMD_GET_MITIGATION_LEVEL_REQ_V01 0x0022
+#define QMI_TMD_GET_SUPPORTED_MSGS_REQ_V01 0x001E
+#define QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01 0x0021
+#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01 0x0023
+#define QMI_TMD_GET_SUPPORTED_MSGS_RESP_V01 0x001E
+#define QMI_TMD_SET_MITIGATION_LEVEL_RESP_V01 0x0021
+#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01 0x0024
+#define QMI_TMD_MITIGATION_LEVEL_REPORT_IND_V01 0x0025
+#define QMI_TMD_GET_MITIGATION_LEVEL_RESP_V01 0x0022
+#define QMI_TMD_GET_SUPPORTED_FIELDS_REQ_V01 0x001F
+#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01 0x0020
+#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01 0x0023
+#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01 0x0024
+#define QMI_TMD_GET_SUPPORTED_FIELDS_RESP_V01 0x001F
+
+#define QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 32
+#define QMI_TMD_MITIGATION_DEV_LIST_MAX_V01 32
+
+struct tmd_mitigation_dev_id_type_v01 {
+	char mitigation_dev_id[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];
+};
+
+static const struct qmi_elem_info tmd_mitigation_dev_id_type_v01_ei[] = {
+	{
+		.data_type = QMI_STRING,
+		.elem_len = QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1,
+		.elem_size = sizeof(char),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0,
+		.offset = offsetof(struct tmd_mitigation_dev_id_type_v01,
+				   mitigation_dev_id),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_mitigation_dev_list_type_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_dev_id;
+	uint8_t max_mitigation_level;
+};
+
+static const struct qmi_elem_info tmd_mitigation_dev_list_type_v01_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0,
+		.offset = offsetof(struct tmd_mitigation_dev_list_type_v01,
+				   mitigation_dev_id),
+		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0,
+		.offset = offsetof(struct tmd_mitigation_dev_list_type_v01,
+				   max_mitigation_level),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_get_mitigation_device_list_req_msg_v01 {
+	char placeholder;
+};
+
+#define TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN 0
+const struct qmi_elem_info tmd_get_mitigation_device_list_req_msg_v01_ei[] = {
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_get_mitigation_device_list_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	uint8_t mitigation_device_list_valid;
+	uint32_t mitigation_device_list_len;
+	struct tmd_mitigation_dev_list_type_v01
+		mitigation_device_list[QMI_TMD_MITIGATION_DEV_LIST_MAX_V01];
+};
+
+#define TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN 1099
+static const struct qmi_elem_info tmd_get_mitigation_device_list_resp_msg_v01_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct qmi_response_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
+				   resp),
+		.ei_array = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type = QMI_OPT_FLAG,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
+				   mitigation_device_list_valid),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
+				   mitigation_device_list_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = QMI_TMD_MITIGATION_DEV_LIST_MAX_V01,
+		.elem_size = sizeof(struct tmd_mitigation_dev_list_type_v01),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_mitigation_device_list_resp_msg_v01,
+				   mitigation_device_list),
+		.ei_array = tmd_mitigation_dev_list_type_v01_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_set_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_dev_id;
+	uint8_t mitigation_level;
+};
+
+#define TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 40
+static const struct qmi_elem_info tmd_set_mitigation_level_req_msg_v01_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct tmd_set_mitigation_level_req_msg_v01,
+				   mitigation_dev_id),
+		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_set_mitigation_level_req_msg_v01,
+				   mitigation_level),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_set_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+#define TMD_SET_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 7
+static const struct qmi_elem_info tmd_set_mitigation_level_resp_msg_v01_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct qmi_response_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_set_mitigation_level_resp_msg_v01, resp),
+		.ei_array = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_get_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+};
+#define TMD_GET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 36
+
+static const struct qmi_elem_info tmd_get_mitigation_level_req_msg_v01_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct tmd_get_mitigation_level_req_msg_v01,
+				   mitigation_device),
+		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_get_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	uint8_t current_mitigation_level_valid;
+	uint8_t current_mitigation_level;
+	uint8_t requested_mitigation_level_valid;
+	uint8_t requested_mitigation_level;
+};
+
+#define TMD_GET_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 15
+static const struct qmi_elem_info tmd_get_mitigation_level_resp_msg_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct qmi_response_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01, resp),
+		.ei_array = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type = QMI_OPT_FLAG,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
+				   current_mitigation_level_valid),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
+				   current_mitigation_level),
+	},
+	{
+		.data_type = QMI_OPT_FLAG,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x11,
+		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
+				   requested_mitigation_level_valid),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x11,
+		.offset = offsetof(struct tmd_get_mitigation_level_resp_msg_v01,
+				   requested_mitigation_level),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_register_notification_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+};
+
+#define TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 36
+static const struct qmi_elem_info
+	tmd_register_notification_mitigation_level_req_msg_v01_ei[] = {
+		{
+			.data_type = QMI_STRUCT,
+			.elem_len = 1,
+			.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
+			.array_type = NO_ARRAY,
+			.tlv_type = 0x01,
+			.offset = offsetof(
+				struct tmd_register_notification_mitigation_level_req_msg_v01,
+				mitigation_device),
+			.ei_array = tmd_mitigation_dev_id_type_v01_ei,
+		},
+		{
+			.data_type = QMI_EOTI,
+			.array_type = NO_ARRAY,
+			.tlv_type = QMI_COMMON_TLV_TYPE,
+		},
+	};
+
+struct tmd_register_notification_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+#define TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 7
+static const struct qmi_elem_info
+	tmd_register_notification_mitigation_level_resp_msg_v01_ei[] = {
+		{
+			.data_type = QMI_STRUCT,
+			.elem_len = 1,
+			.elem_size = sizeof(struct qmi_response_type_v01),
+			.array_type = NO_ARRAY,
+			.tlv_type = 0x02,
+			.offset = offsetof(
+				struct tmd_register_notification_mitigation_level_resp_msg_v01,
+				resp),
+			.ei_array = qmi_response_type_v01_ei,
+		},
+		{
+			.data_type = QMI_EOTI,
+			.array_type = NO_ARRAY,
+			.tlv_type = QMI_COMMON_TLV_TYPE,
+		},
+	};
+
+struct tmd_deregister_notification_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+};
+
+#define TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN 36
+static const struct qmi_elem_info
+	tmd_deregister_notification_mitigation_level_req_msg_v01_ei[] = {
+		{
+			.data_type = QMI_STRUCT,
+			.elem_len = 1,
+			.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
+			.array_type = NO_ARRAY,
+			.tlv_type = 0x01,
+			.offset = offsetof(
+				struct tmd_deregister_notification_mitigation_level_req_msg_v01,
+				mitigation_device),
+			.ei_array = tmd_mitigation_dev_id_type_v01_ei,
+		},
+		{
+			.data_type = QMI_EOTI,
+			.array_type = NO_ARRAY,
+			.tlv_type = QMI_COMMON_TLV_TYPE,
+		},
+	};
+
+struct tmd_deregister_notification_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+#define TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN 7
+static const struct qmi_elem_info
+	tmd_deregister_notification_mitigation_level_resp_msg_v01_ei[] = {
+		{
+			.data_type = QMI_STRUCT,
+			.elem_len = 1,
+			.elem_size = sizeof(struct qmi_response_type_v01),
+			.array_type = NO_ARRAY,
+			.tlv_type = 0x02,
+			.offset = offsetof(
+				struct tmd_deregister_notification_mitigation_level_resp_msg_v01,
+				resp),
+			.ei_array = qmi_response_type_v01_ei,
+		},
+		{
+			.data_type = QMI_EOTI,
+			.array_type = NO_ARRAY,
+			.tlv_type = QMI_COMMON_TLV_TYPE,
+		},
+	};
+
+struct tmd_mitigation_level_report_ind_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+	uint8_t current_mitigation_level;
+};
+
+#define TMD_MITIGATION_LEVEL_REPORT_IND_MSG_V01_MAX_MSG_LEN 40
+static const struct qmi_elem_info tmd_mitigation_level_report_ind_msg_v01_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct tmd_mitigation_level_report_ind_msg_v01,
+				   mitigation_device),
+		.ei_array = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_mitigation_level_report_ind_msg_v01,
+				   current_mitigation_level),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+#endif /* __QMI_COOLING_INTERNAL_H__ */

-- 
2.42.0

