Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1E2B7552
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 05:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKREMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 23:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKREMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 23:12:31 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E6C061A51
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 20:12:31 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id h10so82471ooi.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 20:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qOty3AIPBhYewFt7PpUmMM+e5nNODFbdVyWPzXIidq8=;
        b=ftPCZdIyUTg7frD8YRIDk2i/jp0qt8qhZxBMCzHZ0ul9TqO+G121Dx5Ou1wnb0iqw4
         hkI9e3dJXwTttyKrJPUMO7SVOmhbb3Bi7wRsk9ABlm+TH/G0sZexfnF2BX2AZN5n5nDJ
         TpP2Vp8tfkJ+HNZL9W7R+dLECl5OQJLU2HLi5xrfwlaw8JxcbiCM/KDuwg1nGkPIkqTt
         qXLFG0KuNXNawd08/QKYRijN/MyqZywp7CEqy8GDQtbK2EAm5Wb2iV9cJD+in1nCn3nS
         78yW75B2kN419EvUdWEOdUCfEqWQwjgca8ycKEFZSOqeX4DqnFIpamhz9yH+0CwrJ3wb
         5zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qOty3AIPBhYewFt7PpUmMM+e5nNODFbdVyWPzXIidq8=;
        b=F5ZuAoDDX/yiuTBbiB61R4PX+hLSpkiMeokUQNIW/VOiipA9lEGI3WtG1iNnkOKdvw
         tU7iX922A8IpcDLN1KzKJHJkARsJL08josovYX+HFYfsmJMG/6WqxPKZtzAIpFSGDaz7
         q0SFkp/MCQ6V1wHrlHXIfx/9Vk+krLiczzrGBdIsspYWZuOdgqNc0EQ4obNrbOlvfnp+
         XRH9A3/0C8Bzua1hoHdekWq43UW/ijkSTnFDKwNCLHlx/+D3eTAj3CsmfvglXjRpxtEf
         SvxbtvGxRbe3Uz+MKwhKNiR8AgRzJGxVTiHPO7ENCPX6e9u8+4y9taLNYGyXDmDjbDT3
         e1uw==
X-Gm-Message-State: AOAM532I3fFtauQgjL+jz/GLZdH2N4uPseRcOPqFFVlF4dXTKXrigUeu
        DGRlygktfRkRPC18VnDfNg/1DA==
X-Google-Smtp-Source: ABdhPJy0Er+0gl6Ev9T+ww1XOKNYDPLRCN9y2ZefS6H1tYQsIdl7eS4trHL73fO3+ha0624IZD+viw==
X-Received: by 2002:a4a:b409:: with SMTP id y9mr5217506oon.70.1605672751118;
        Tue, 17 Nov 2020 20:12:31 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t5sm7020940oth.16.2020.11.17.20.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 20:12:30 -0800 (PST)
Date:   Tue, 17 Nov 2020 22:12:28 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: qcs404: Remove gpu and display nodes
Message-ID: <20201118041228.GG8532@builder.lan>
References: <20201111100734.307-1-georgi.djakov@linaro.org>
 <357bd51c-7217-3e9b-ead9-a20f99c264f6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357bd51c-7217-3e9b-ead9-a20f99c264f6@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 17 Nov 17:16 CST 2020, Mike Tipton wrote:

> On 11/11/2020 2:07 AM, Georgi Djakov wrote:
> > The following errors are noticed during boot on a QCS404 board:
> > [    2.926647] qcom_icc_rpm_smd_send mas 6 error -6
> > [    2.934573] qcom_icc_rpm_smd_send mas 8 error -6
> > 
> > These errors show when we try to configure the GPU and display nodes,
> > which are defined in the topology, but these hardware blocks actually
> > do not exist on QCS404. According to the datasheet, GPU and display
> > are only present on QCS405 and QCS407.
> 
> Even on QCS405/407 where GPU and display are present, you'd still get these
> errors since these particular nodes aren't supported on RPM and are purely
> local. Instead of removing these we should just change their mas_rpm_id to
> -1. It's harmless to leave them in for QCS404 since they're only used for
> path aggregation. The same code can support all variants of the QCS400
> series. We just wouldn't expect anyone to actually vote these paths on
> QCS404. Similar to how the gcc-qcs404 clock provider still registers the GPU
> and MDP clocks.
> 

That would definitely be preferable and would save us from having 4 (?)
copies of qcs40x...

Regards,
Bjorn

> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >   drivers/interconnect/qcom/qcs404.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> > index 9f992422e92f..2ed544e23ff3 100644
> > --- a/drivers/interconnect/qcom/qcs404.c
> > +++ b/drivers/interconnect/qcom/qcs404.c
> > @@ -20,8 +20,6 @@
> >   enum {
> >   	QCS404_MASTER_AMPSS_M0 = 1,
> > -	QCS404_MASTER_GRAPHICS_3D,
> > -	QCS404_MASTER_MDP_PORT0,
> >   	QCS404_SNOC_BIMC_1_MAS,
> >   	QCS404_MASTER_TCU_0,
> >   	QCS404_MASTER_SPDM,
> > @@ -156,8 +154,6 @@ struct qcom_icc_desc {
> >   	}
> >   DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
> > -DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, 6, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
> > -DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, 8, -1,
> > QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV >
> > DEFINE_QNODE(mas_snoc_bimc_1, QCS404_SNOC_BIMC_1_MAS, 8, 76, -1,
> QCS404_SLAVE_EBI_CH0);
> >   DEFINE_QNODE(mas_tcu_0, QCS404_MASTER_TCU_0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
> >   DEFINE_QNODE(mas_spdm, QCS404_MASTER_SPDM, 4, -1, -1, QCS404_PNOC_INT_3);
> > @@ -231,8 +227,6 @@ DEFINE_QNODE(slv_lpass, QCS404_SLAVE_LPASS, 4, -1, -1, 0);
> >   static struct qcom_icc_node *qcs404_bimc_nodes[] = {
> >   	[MASTER_AMPSS_M0] = &mas_apps_proc,
> > -	[MASTER_OXILI] = &mas_oxili,
> > -	[MASTER_MDP_PORT0] = &mas_mdp,
> >   	[MASTER_SNOC_BIMC_1] = &mas_snoc_bimc_1,
> >   	[MASTER_TCU_0] = &mas_tcu_0,
> >   	[SLAVE_EBI_CH0] = &slv_ebi,
> > @@ -460,6 +454,9 @@ static int qnoc_probe(struct platform_device *pdev)
> >   	for (i = 0; i < num_nodes; i++) {
> >   		size_t j;
> > +		if (!qnodes[i])
> > +			continue;
> > +
> >   		node = icc_node_create(qnodes[i]->id);
> >   		if (IS_ERR(node)) {
> >   			ret = PTR_ERR(node);
> > 
