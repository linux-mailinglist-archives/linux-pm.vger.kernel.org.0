Return-Path: <linux-pm+bounces-15401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1624996C8F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A853F1F237B2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353B81990C8;
	Wed,  9 Oct 2024 13:46:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50538DE5;
	Wed,  9 Oct 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481609; cv=none; b=SPq7gkpujA3eROVdWy9n3U6WoDBdDrQjh9QMx2XCmObdaIIRHk0UCXb1MgEVvqyFP+KNzGIN3XoYt219gBW/TyyawMd6D+c8xRpBOzmy4W/ESCmFtmwQtFuBfxOwGLfxYmuAehLiLICmvBxa3A0A/szIZkaIOe9uQ5DBRjCOTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481609; c=relaxed/simple;
	bh=bLKZ5gZUn7I4XAOhOy9/2kjUpjXZpY9A0U/l2hd18XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBcmLWAG3Qn/rYPPBW/fX6uG9oXFGSDcFPhbIxrWgaWemRNgUayweLzfWL0Muwig/BZ1dTWn+02oe6zqJ0hAooQeSLV3m58CK3Fpk1K755T5EBUEmCtzWGZg7tED5AKwl9HGvz6hINq5N+dnQxM2xQjZJ4tDH5kKzCx0s7Dk6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6E92FEC;
	Wed,  9 Oct 2024 06:47:15 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F65F3F58B;
	Wed,  9 Oct 2024 06:46:44 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:46:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <ulf.hansson@linaro.org>,
	<jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <johan@kernel.org>,
	<konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
	<tstrudel@google.com>, <rafael@kernel.org>,
	"Johan Hovold" <johan+linaro@kernel.org>
Subject: Re: [PATCH V3 1/4] firmware: arm_scmi: Ensure that the message-id
 supports fastchannel
Message-ID: <ZwaJQmO4a7cM7MFY@bogus>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007060642.1978049-2-quic_sibis@quicinc.com>

On Mon, Oct 07, 2024 at 11:36:39AM +0530, Sibi Sankar wrote:
> Currently the perf and powercap protocol relies on the protocol domain
> attributes, which just ensures that one fastchannel per domain, before
> instantiating fastchannels for all possible message-ids. Fix this by
> ensuring that each message-id supports fastchannel before initialization.
>

Looks good to me. With the minor nit below addressed,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

(assuming you will take this all via pmdomain or qcom soc tree)

> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/driver.c    | 9 +++++++++
>  drivers/firmware/arm_scmi/protocols.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 88c5c4ff4bb6..80a9a615672a 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -56,6 +56,9 @@ static atomic_t transfer_last_id;
>
>  static struct dentry *scmi_top_dentry;
>
> +static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
> +				   u32 message_id, u32 *attributes);
>

I prefer to just move the function above if possible to avoid this extra
declaration just keep keep it consistent with other such internal/static
function calls within this file. No hard opinion, just preference to avoid
me thinking(or scratching my head) why only this is done different few
months down the line.

--
Regards,
Sudeep

