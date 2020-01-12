Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581C61386D4
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2020 15:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbgALOpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 09:45:44 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:55146 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbgALOpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 09:45:43 -0500
IronPort-SDR: GExzujQipyDp4uXBLXXIUUufEJRCuJTGa5cdofzuSljgi2+cTEwkiQ27enlfotTlEGVYgV9OSD
 nlONB7z9mKOA==
IronPort-PHdr: =?us-ascii?q?9a23=3A0CLgFR+u2UisGf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+scTK2v8tzYMVDF4r011RmVBN6dsawUwLSJ+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanf79/LRa7oQrQu8QUnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRBnvhCkaKzE26mTXi8xpgK9FpxKhvQR/w4nOYI6PKPpxYLrRcs0cRW?=
 =?us-ascii?q?ZYQstRSzBBDZmgYIsPEeUBOPhXr4/hp1cXsxS+AxCgCuToyj9OmHD33bQ23P?=
 =?us-ascii?q?onEQrb2AAtEc4CvGjRoNjzKawcU/26zLPQwDvNb/1Wwynz5ovVfB8uvf6CUq?=
 =?us-ascii?q?l9cdbTxEYzCw/JkkmcpZLjMjiI1uoNqW+b7+94WOy1lWEntx9+oiKyzcgsjY?=
 =?us-ascii?q?nJgI0VwU3D+CVh3ok1OcO3SFR1YN6jFptQuDqXN4ttQsw5X25kojo1yroDuZ?=
 =?us-ascii?q?KhfCgKy40qyhjCYPKEa4iF+gzvWPuTLDtimX5odq6ziwys/UWv0OHwSNS43V?=
 =?us-ascii?q?RMoyFYiNfDrGoN2AbW6sWfT/t9+Vqu1iiX2gDI7+FEPVg0la3GK5492rIwlo?=
 =?us-ascii?q?QcsUDEHiLunUX5lq6WdkE++ue27+TrfrvrqoWCN49zlw7xKKoumsu5AesmKA?=
 =?us-ascii?q?QBQXOb9fy91L3l40L5XK1HguMrnqTbqpzWOMoWqrKjDwNL3Ysv8QizAyqk3d?=
 =?us-ascii?q?gAmHkINlNFeBaJj4jzPFHOJej1De+hjFSwjjhr3f7HPrrnApXCNXXDkKzhcq?=
 =?us-ascii?q?1h5EJG1AUzytVf64hUCrECOP7zQFP+tMTEDh8lNAy52+LnCNR71oMDVmODG7?=
 =?us-ascii?q?eZMKbJvF+W6eIgPfOMaJUWuDnjMfgl4eDhjXsjlV8aZ6mp0shfVHftGvVgPl?=
 =?us-ascii?q?XceX/EnNgMCyEJsxA4Qeisj0eNAgRef3KjY6Vp3jwnBZjuMoDFScj5mKPYg3?=
 =?us-ascii?q?fnTsZ+aWVPC1TKGnDtIdaqQfAJPRqfPsJ72gMDU7fpH5csyRy0qwj8xJJnNe?=
 =?us-ascii?q?DfvCYfsNTj144mtKXoiRgu+GktXIym2GaXQjQvxjsF?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HhAgBpMBteXdkYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBARgBAYEugU1SIBKNOYdkH4F?=
 =?us-ascii?q?KgXmLY4EAggqBFBWGBxQMgVsNAQEBAQEbGgIBAYRATgEXgTM1CA4CAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECAxoWBYV0QgEBBAcBgU0MHgEEAQEBAQMDAwEBDAGDXQcZDzk?=
 =?us-ascii?q?pIUwBDgEET4VPAQEznUMBhASJAA0NAoUdgkUECoEJgRojgTYBjDKBQT+BIyG?=
 =?us-ascii?q?CKwgBggGCfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxC?=
 =?us-ascii?q?CRQ4BHG2IA4ROgX2jN1d0AYEecTMagiYagSBPGA2WSECBFhACT4RNgUmFJII?=
 =?us-ascii?q?yAQE?=
X-IPAS-Result: =?us-ascii?q?A2HhAgBpMBteXdkYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBARgBAYEugU1SIBKNOYdkH4FKgXmLY4EAggqBF?=
 =?us-ascii?q?BWGBxQMgVsNAQEBAQEbGgIBAYRATgEXgTM1CA4CAw0BAQUBAQEBAQUEAQECA?=
 =?us-ascii?q?xoWBYV0QgEBBAcBgU0MHgEEAQEBAQMDAwEBDAGDXQcZDzkpIUwBDgEET4VPA?=
 =?us-ascii?q?QEznUMBhASJAA0NAoUdgkUECoEJgRojgTYBjDKBQT+BIyGCKwgBggGCfwESA?=
 =?us-ascii?q?WyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ4BHG2IA4ROg?=
 =?us-ascii?q?X2jN1d0AYEecTMagiYagSBPGA2WSECBFhACT4RNgUmFJIIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,425,1571695200"; 
   d="scan'208";a="304185890"
Received: from smtp.iservicesmail.com (HELO mailrel03.vodafone.es) ([217.130.24.217])
  by mail01.vodafone.es with ESMTP; 12 Jan 2020 15:45:41 +0100
Received: (qmail 27572 invoked from network); 12 Jan 2020 14:45:38 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel03.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-pm@vger.kernel.org>; 12 Jan 2020 14:45:38 -0000
Date:   Sun, 12 Jan 2020 15:45:41 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <pw178483@gmail.com>
To:     linux-pm@vger.kernel.org
Message-ID: <17253342.558776.1578840341320.JavaMail.cash@217.130.24.55>
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

