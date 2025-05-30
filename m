Return-Path: <linux-pm+bounces-27836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F29AC8912
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829FC4A38F1
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C021ABB9;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4FiFXcg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67236217736;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590541; cv=none; b=jc5nCnxh7yefkg1LnIGMgcHfA65SN5TWO1SSyERMWy4/sF1llckcCuhj7LKwcaB7A3J6acKt5Qxc7k98iDaJj5fPfeRgl41tJTx8ossGO0QOFMuoXu2GXJclSTLJSRY07/KBq/8WciZ3TnksRvJ1iY+ZKvePBJkP+Fh4Z9WLWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590541; c=relaxed/simple;
	bh=SLH0/e6jpaZePdqGNp9px61CLgYmQRPgVnhUwsNM8w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTwN8ithilMjN/5xvRLflTvIYVQ5FAc+W/lw9pWgX/+HuR+YO2P8kbBz3Udm3FdWt9QJuK9VYdz/ZpKk+VTpkfUmZxKYUJPZ2QE9t78Pv2ayY76IJ+fyM2VG8/UqeaR4M4IUx171H9/xrixMeEPa3cKiTYX/K3u0I5K2wQJ75vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4FiFXcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BBA3C4CEFB;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=SLH0/e6jpaZePdqGNp9px61CLgYmQRPgVnhUwsNM8w4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U4FiFXcgWGJcN/8TCmcb35p4a2b+cpoGgG2j4vCaBwxKVLSBxJ9DM3FyVqNuOvUvc
	 sGykvGx8x85yFN2m/2oFWLV4udVvVC2fIXV/AdOMrgaCFE0p2nbvJtWYqH6DAuzjpo
	 tPkX96KCaKMvWr8iS3gkdYZOHAhJDdMyqoWR4fBPpAH7FhdV6g1gLCJetu5Ko+ZdMa
	 fTh17xQLFoeQsHzC6r0mrra/ChDQ9S4/clLH8JolTdo/v4/XLgjonsgzwsyXZyK68v
	 FFVaI2B9K5/35kofw1lsaWU7/gbVptM1RxBB+VwMgwQnFMUHjnEiVcu7zh0AmzJg84
	 l17chgEFbUDpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB3C5B549;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 30 May 2025 15:35:11 +0800
Subject: [PATCH v2 6/8] dt-bindings: soc: qcom: pmic-glink: Move X1E80100
 out of fallbacks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-qcom_battmgr_update-v2-6-9e377193a656@oss.qualcomm.com>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
In-Reply-To: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=1055;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=Cum9h5T8HOEqZYRtn+XVwUsJjYopn4P2b00zD/gfTPk=;
 b=/hIg7NchpOii0i76vHdkSEiRHdTrH5KjZa/MLTucRF+++OFB39/RfeGLaIx+bJr85TDrx6E7U
 Hmyij3OpD+wDfzqRGCIzUykjGLpqVxP+u9ORjXqDHcCI5UqWCdIpxJF
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Move X1E80100 out of the fallbacks of SM8550 in pmic-glink support.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..972bec151118f2e20e1f3b4e0c0a8fbbbea7ab90 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -39,9 +39,11 @@ properties:
           - enum:
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
-              - qcom,x1e80100-pmic-glink
           - const: qcom,sm8550-pmic-glink
           - const: qcom,pmic-glink
+      - items:
+          - const: qcom,x1e80100-pmic-glink
+          - const: qcom,pmic-glink
 
   '#address-cells':
     const: 1

-- 
2.34.1



