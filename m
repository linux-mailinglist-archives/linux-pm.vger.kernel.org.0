Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C913844F
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2020 01:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbgALApM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 19:45:12 -0500
Received: from mail3.iservicesmail.com ([217.130.24.75]:5245 "EHLO
        mail3.iservicesmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731788AbgALApM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 19:45:12 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jan 2020 19:45:10 EST
IronPort-SDR: Gb9goo/9RD1OayBFzFpwYc5YJZrP+eWu6qofA8iBgKgdrpa+Ez+QTqD+L8FF4UBOD4XLKebvZo
 lXziHzNMh5lA==
IronPort-PHdr: =?us-ascii?q?9a23=3ANJNzJRGeOLv/UEQjOMY84J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr8iwAkXT6L1XgUPTWs2DsrQY0rGQ6f6+EjZaqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnct8gbjYR8Jqov1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOzg+/G/KlsN/lqdboRK4qxFhxI7UepmVNP1kfqzHYdMVW3?=
 =?us-ascii?q?NNUdhXVyBYHo68c5cPAPAdMuZYsYb9okUBrR2iBQW1GuzvzCZEiHjx3a08ze?=
 =?us-ascii?q?sgERjK0xImH9kTtHjZosn5OLsXXe2z0aLGzyjMb+lO1Dnz6IbIaA4vr/KRU7?=
 =?us-ascii?q?1/bcXfxlIiFx/Hg1qMtYDpIy+Z2voLvmOG7+RgT+Wvi2s/pg9rvDev2tkjip?=
 =?us-ascii?q?PUjY0VzVDE8yp5y5syKN2gVkF7fcCrEIFetiGdMYt2TdgvQ2FzuCkh1rIKo4?=
 =?us-ascii?q?K0fC8PyJg9xx7faOWKfo6V6RzgTOacOSl0iG9ndb6lmhq//1SsxvfiWsS7yl?=
 =?us-ascii?q?pHoCpIn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+TbEok++yo6/75bbXiupOROJV4ih/5MqszgMO/D+M4Mg?=
 =?us-ascii?q?4QUGSB5+u8z6Xv/Uz/QLpUkv07irfVvI3YKMgBu6K0DRNZ3pw95xuwFTur3t?=
 =?us-ascii?q?QVkWECLF1feRKHi4bpO0vJIPD9Ffq/m0qjkCt1yPDcMLzhBZPNLnfYnbfhZr?=
 =?us-ascii?q?Zy8FJTxBAvwtBY4pJYELEBIPHrVk/rqNPYFgM5MxCzw+v/DNV914UeWX+AA6?=
 =?us-ascii?q?OAKKPStESF5vwgI+aSfo8ZojX9JOY/5/7ok3A5nUURfa6z3ZsYOziEGaFiIk?=
 =?us-ascii?q?OEcT/0h/8fHmoQ+AkzVurnjBuFSzEAXXuqW7MA4WQDBZ6rF8/8QYaiyOiZ0T?=
 =?us-ascii?q?u2BIJRYG9GEVqHEXTAeICNWvNKYyWXdJxPiDsBAICsV4I7nS6psgCyn6JqMu?=
 =?us-ascii?q?fO5Soeurrjz9J+oebUkFcy9monXIymz2iRQjQtzSszTDgs0fUk+RRw?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HVAQCpaRpelyMYgtlMGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwQBgSmBTVIgEpNQgU0fg0O?=
 =?us-ascii?q?LY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQE?=
 =?us-ascii?q?FBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVO?=
 =?us-ascii?q?DBIJLAQEznXcBjQQNDQKFHYJBBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ?=
 =?us-ascii?q?/ARIBbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAO?=
 =?us-ascii?q?EToF9ozdXdAGBHnEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HVAQCpaRpelyMYgtlMGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwQBgSmBTVIgEpNQgU0fg0OLY4EAgx4VhgcUD?=
 =?us-ascii?q?IFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBA?=
 =?us-ascii?q?QYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEznXcBj?=
 =?us-ascii?q?QQNDQKFHYJBBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEj?=
 =?us-ascii?q?UISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXdAGBH?=
 =?us-ascii?q?nEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,423,1571695200"; 
   d="scan'208";a="303823308"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 12 Jan 2020 01:40:08 +0100
Received: (qmail 8509 invoked from network); 11 Jan 2020 23:46:32 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-pm@vger.kernel.org>; 11 Jan 2020 23:46:32 -0000
Date:   Sun, 12 Jan 2020 00:46:30 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghsbchk@gmail.com>
To:     linux-pm@vger.kernel.org
Message-ID: <11132381.172083.1578786392182.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

