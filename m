Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0A1B11B3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgDTQh3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgDTQh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 12:37:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609FC025492
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 09:37:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so5336068pgo.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaH8yNJsOAKln94uq+HFtZzBAuD4hS9jJ0pAud4DQIg=;
        b=e8Ovza3SdNN5nFyqKxl/8JTdLYTtOWhuOD5PiDSeqEU9BQsP5zxLxtVDvvU9OXgzAz
         mMQ+MIW70lIgq10qgL0YDh2r0caE62h/vKDqz+u1nQl7zLlZYkzrDBdToizOG+5y2wgz
         4YbgQ2QRmM9hFX+N0jLBAjrgZHzoGVl2cnggs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaH8yNJsOAKln94uq+HFtZzBAuD4hS9jJ0pAud4DQIg=;
        b=VaYnE9A/wS1QFD3KIAwrykUCpT0JcqYfm+PNDGwNKj2wwqN+NEL+IjiZkiMtxaPh6q
         c2llGzwlmHrP6Zi6oZqsq40qgB3/I62Bhp1Agr2GJljAyrI32thZKrsrDiSAXfI8ISD2
         XMV2mqscJt+XdBvEL/DqXVnG8HNfsM2SbQcMez5CSF6I6r06/VVOPUlptppw7JKxYC/K
         ttfObSONO+wUPEzNePVjUbklrGjxKTmM00S4v5bctUIVBFro8sGoro8urCsmcDVAxYWp
         6ilP2LE0qvqnp6gDkD9vzmsIJysDdlXP6imiQLr2C4mo2ax0u3BHv8iaW9eywx4nuT22
         sZ7w==
X-Gm-Message-State: AGi0PuaCGzNr99Sbi/qoBKWxuwfJmmsWfsn6QtmRhZwzcPIamktSKXqe
        FFiVSJ+m+lfn5mTtiih+HvenmA==
X-Google-Smtp-Source: APiQypJKX0wGCNMD3rOzlXzUDOiaHzdUncUSYu8YzvA5TKhy+8Swdz8Tr/cEhekUU1mr4V9YeZPOHA==
X-Received: by 2002:a63:48a:: with SMTP id 132mr17450292pge.380.1587400647916;
        Mon, 20 Apr 2020 09:37:27 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id cp22sm98109pjb.28.2020.04.20.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:37:27 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v0 1/2] typec: Move typec class structs into a header file
Date:   Mon, 20 Apr 2020 10:36:56 -0600
Message-Id: <20200420163657.60650-2-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420163657.60650-1-mathewk@chromium.org>
References: <20200420163657.60650-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the Type-C data structures into a separate header file so that they
can be used by in other places.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/usb/typec/class.c | 56 +----------------------------------
 drivers/usb/typec/class.h | 61 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 55 deletions(-)
 create mode 100644 drivers/usb/typec/class.h

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 8d894bdff77d..9a1fdce137b9 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -13,61 +13,7 @@
 #include <linux/slab.h>
 
 #include "bus.h"
-
-struct typec_plug {
-	struct device			dev;
-	enum typec_plug_index		index;
-	struct ida			mode_ids;
-};
-
-struct typec_cable {
-	struct device			dev;
-	enum typec_plug_type		type;
-	struct usb_pd_identity		*identity;
-	unsigned int			active:1;
-};
-
-struct typec_partner {
-	struct device			dev;
-	unsigned int			usb_pd:1;
-	struct usb_pd_identity		*identity;
-	enum typec_accessory		accessory;
-	struct ida			mode_ids;
-};
-
-struct typec_port {
-	unsigned int			id;
-	struct device			dev;
-	struct ida			mode_ids;
-
-	int				prefer_role;
-	enum typec_data_role		data_role;
-	enum typec_role			pwr_role;
-	enum typec_role			vconn_role;
-	enum typec_pwr_opmode		pwr_opmode;
-	enum typec_port_type		port_type;
-	struct mutex			port_type_lock;
-
-	enum typec_orientation		orientation;
-	struct typec_switch		*sw;
-	struct typec_mux		*mux;
-
-	const struct typec_capability	*cap;
-	const struct typec_operations   *ops;
-};
-
-#define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
-#define to_typec_plug(_dev_) container_of(_dev_, struct typec_plug, dev)
-#define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
-#define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
-
-static const struct device_type typec_partner_dev_type;
-static const struct device_type typec_cable_dev_type;
-static const struct device_type typec_plug_dev_type;
-
-#define is_typec_partner(_dev_) (_dev_->type == &typec_partner_dev_type)
-#define is_typec_cable(_dev_) (_dev_->type == &typec_cable_dev_type)
-#define is_typec_plug(_dev_) (_dev_->type == &typec_plug_dev_type)
+#include "class.h"
 
 static DEFINE_IDA(typec_index_ida);
 static struct class *typec_class;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
new file mode 100644
index 000000000000..ec933dfe1323
--- /dev/null
+++ b/drivers/usb/typec/class.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_CLASS_H__
+#define __USB_TYPEC_CLASS_H__
+
+struct typec_plug {
+	struct device			dev;
+	enum typec_plug_index		index;
+	struct ida			mode_ids;
+};
+
+struct typec_cable {
+	struct device			dev;
+	enum typec_plug_type		type;
+	struct usb_pd_identity		*identity;
+	unsigned int			active:1;
+};
+
+struct typec_partner {
+	struct device			dev;
+	unsigned int			usb_pd:1;
+	struct usb_pd_identity		*identity;
+	enum typec_accessory		accessory;
+	struct ida			mode_ids;
+};
+
+struct typec_port {
+	unsigned int			id;
+	struct device			dev;
+	struct ida			mode_ids;
+
+	int				prefer_role;
+	enum typec_data_role		data_role;
+	enum typec_role			pwr_role;
+	enum typec_role			vconn_role;
+	enum typec_pwr_opmode		pwr_opmode;
+	enum typec_port_type		port_type;
+	struct mutex			port_type_lock;
+
+	enum typec_orientation		orientation;
+	struct typec_switch		*sw;
+	struct typec_mux		*mux;
+
+	const struct typec_capability	*cap;
+	const struct typec_operations   *ops;
+};
+
+#define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
+#define to_typec_plug(_dev_) container_of(_dev_, struct typec_plug, dev)
+#define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
+#define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
+
+static const struct device_type typec_partner_dev_type;
+static const struct device_type typec_cable_dev_type;
+static const struct device_type typec_plug_dev_type;
+
+#define is_typec_partner(_dev_) (_dev_->type == &typec_partner_dev_type)
+#define is_typec_cable(_dev_) (_dev_->type == &typec_cable_dev_type)
+#define is_typec_plug(_dev_) (_dev_->type == &typec_plug_dev_type)
+
+#endif /* __USB_TYPEC_CLASS_H__ */
-- 
2.26.1.301.g55bc3eb7cb9-goog

