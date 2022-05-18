Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E264752BCD4
	for <lists+linux-pm@lfdr.de>; Wed, 18 May 2022 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiERN3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiERN2m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 09:28:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673D1BE117
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 06:28:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so3958780pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cyJx2Ikk3M6UREufrh2Jxx8zfYV2z4VljnQeZDclXoY=;
        b=nAIZWcCQB0vEb9Hi5ushwVJZSD3o0Tc6//fRfTNV7FBk5tCIzKAoqjzGPrE1mdIWXY
         DQTe3O40KH/Ja4N36vW17qmplhql2M75ZNPepdcNiNnN4Pauuhu0I+p704bP+5jPtY7G
         kI3kj70JEr2G6C4P2Z5epOLsdSSX4B6UKyn+f2o6EYBIE/F//87hCW6GRqSjlqGd2mSN
         RuzZDH/hurmV0y++ddqDJ4eGDDVbtqhplvDFcFS3wTLLz9GFyT3YT2/OD7FdRaKbRLbD
         TVTerhPsWMEDIKL42XkFCDljIQ84D1h96PsHD19F6YTrxNsarsxVo577uAsEnTTVYOQu
         M0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cyJx2Ikk3M6UREufrh2Jxx8zfYV2z4VljnQeZDclXoY=;
        b=KbAI1yO92zg600ZbqlvW9SYQD8aDgiiZLY/yAyF1c8WfPrR+MMWqYhp1mGx42BsBQe
         vdYF13iemykI0Gol2Z1NHklgAExBdeGJT14gwRNBNzlxCPdCOCytMRxytyHZ2iNTWPbx
         WwFzSTzX3q5hd1Eg5MbuDPtFh9yE7sB69r3MsHkr/muqtDw12ew5ab7QiQDOIN3zbkd3
         o0s4YaOjHlvU388EIInFFgQqnuFewyHwjQKjgKVoW+iu87n7N2D/ajHgXfckCk43sF7l
         n7XSpHt5OJW6X0zlTdnErtF7SPsfl5ZJSKvyjAONh9pIAReXE5VB08GHgUs8wYsrzosr
         kvug==
X-Gm-Message-State: AOAM533BN7CInPZzPmZLKALjnWnfWmh/41+B7H3SRL/oXPkEbqUbsLxK
        b40ZI1RTesthrxOR25EC0uPF
X-Google-Smtp-Source: ABdhPJzB+pOxRPGTV08iwOjpsuVMYv3p58e06J814Q36NWj7SUgbEYF+KcxLnJLZX577FAOHqLDTdQ==
X-Received: by 2002:a17:90b:50b:b0:1dc:a0b1:c783 with SMTP id r11-20020a17090b050b00b001dca0b1c783mr42309190pjz.49.1652880484629;
        Wed, 18 May 2022 06:28:04 -0700 (PDT)
Received: from thinkpad ([117.217.181.192])
        by smtp.gmail.com with ESMTPSA id bf7-20020a170902b90700b0015f2e3e495asm1653407plb.239.2022.05.18.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 06:28:04 -0700 (PDT)
Date:   Wed, 18 May 2022 18:57:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add system PM support
Message-ID: <20220518132757.GC4791@thinkpad>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
 <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
 <20220518132358.GA26902@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518132358.GA26902@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 18, 2022 at 03:23:58PM +0200, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 06:49:13PM +0530, Manivannan Sadhasivam wrote:
> > From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> > 
> > Add suspend and resume callbacks to handle system suspend and resume in
> > the Qcom PCIe controller driver. When the system suspends, PME turnoff
> > message will be sent to the device and the RC driver will wait for the
> > device to enter L23 Ready state. After that, the PHY will be powered down
> > and clocks/regulators will be disabled.
> 
> So what about just not doing this stupid power disabling to start
> with?  Unlike x86 where we do not have choice due to the BIOS, we
> apparently do here.  And disabling power is the wrong thing to do at
> least for SSDs as it massively increases the wear on the NAND.

That's the requirement the Chromebook based on SC7280 has. I will check
internally and get back.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
