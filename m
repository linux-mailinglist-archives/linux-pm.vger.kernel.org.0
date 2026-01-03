Return-Path: <linux-pm+bounces-40153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B34ECF0172
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FA423006992
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CFF30DEBD;
	Sat,  3 Jan 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEV2vZvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237819B5A7;
	Sat,  3 Jan 2026 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767452943; cv=none; b=UVWQSueCgujslpF98JnM2JwGqFRxwliYKnHNhxIISMXd4D54Xn+moWweg4jr5YsAt3YCf4ktTQdbdLTbtfhQF/dB0/63Y4tp0JnTABBi3xgp4j21xN7UG8bRxKDiMvvhe2Kf5EJN3KR2UUptBk9tokFGuUWxocophrwyv6X17do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767452943; c=relaxed/simple;
	bh=qf9s2CWSLPPGzJ0/0o/pgRvVIG8OsurR4bC3Cxi2ecI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoRm9EtvfFdcFE5w4MnKxF1opVaF0wci9ipbWocbe8gWWJBu6ZCnSoxO8BPVoNlypD8Yk0krcmrWGU7hQQUqdcUETF4N/89XgF8+aDh/+ltaB+w6FxZv579nVjxU8mCMhEXZ0eAwDTFp9QY2Z3yEj2Oy9kNB3aeWtvR+MCHX5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEV2vZvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC0BC113D0;
	Sat,  3 Jan 2026 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767452942;
	bh=qf9s2CWSLPPGzJ0/0o/pgRvVIG8OsurR4bC3Cxi2ecI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEV2vZvh4QWjHb9lssW/XfRHdwLJxDPWINU4otZelCN3zleAfQhNUavQGHcvhq4bm
	 LDjsSvA7sdAoTS5F4iTO+AHHAW2YGIliD2JcGc/Jpg6XMFQBJpLFjhcfoZdCf/TEpV
	 nSxxD9eOeQEtDfw4GLjr/8kLSWz19q1wNT2+rXBn8NQqbRwv/DBY4GSEvQ6g06knCh
	 XSZeikpJkVPJNXj2btrYeHRYSrmucq9CexpJvVUkL7inoZnDtpV82jrUOn1T8cbykC
	 MYol3h5NGFxZp0pm+lNiIicvmalbJHwazV7UJ9OuB6CiRzPf/CMBLAuA8Je4MwCdvn
	 KiKs5ToB97pMg==
Date: Sat, 3 Jan 2026 09:08:58 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org, 
	casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <spnzzacpelmkzccithxwnhr2e6fncuqrd46ybhplnryl2fnswy@pblwhdupnxws>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <fu7rhvpo7t2fjx4l7nvzd2cec7loyjeqyvwgochghyyax4nqof@6bat54r3qgov>
 <7e946103-06cc-4e44-be00-fd0ab9a8f55c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e946103-06cc-4e44-be00-fd0ab9a8f55c@oss.qualcomm.com>

On Wed, Dec 24, 2025 at 01:54:04PM +0530, Gaurav Kohli wrote:
> On 12/24/2025 1:00 AM, Dmitry Baryshkov wrote:
> > On Tue, Dec 23, 2025 at 06:02:22PM +0530, Gaurav Kohli wrote:
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
[..]
> > > +  vdd:
> > > +    $ref: "#/definitions/tmd"
> > > +    description:
> > > +      Modem processor temperature TMD
> > > +    properties:
> > > +      label:
> > > +        const: modem
> > Why it being called vdd?
> > 
> > Why do you define modem-specific node here, while the CDSP-specific is
> > defined under the if block?
> 
> 
> will remove modem in next post,  earlier we were developing for all
> subsystem.
> right now wanted to post for cdsp subsystem first, will fix in next post.
> 

No, upstream the binding and driver for all known endpoints (and test to
the best of your ability), then enable the ones you have on your
platform.

[..]
> > 
> > > +              label = "cdsp_sw";
> > > +              #cooling-cells = <2>;
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +    remoteproc-cdsp1 {
> > > +        cooling {
> > > +            compatible = "qcom,qmi-cooling-cdsp1";
> > > +
> > > +            cdsp_sw1: cdsp_sw {
> > > +              label = "cdsp_sw";
> > > +              #cooling-cells = <2>;
> > > +            };
> > > +        };
> > > +    };
> > What's the point of having the second CDSP block? Could you demonstrate
> > modem instead?
> 
> 
> Missed one cdsp1 block in this series, will add in next post. Leman's is
> using two cdsp subsystem for that we need cdsp1.
> 

It's just an example, make it as informative as possible.

Regards,
Bjorn

> 
> > > +...
> > > -- 
> > > 2.34.1
> > > 

