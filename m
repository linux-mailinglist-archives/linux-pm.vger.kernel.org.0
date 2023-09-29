Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1867B3833
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjI2Q4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjI2Q4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 12:56:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895641B4
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 09:56:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405524e6740so125646535e9.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696006595; x=1696611395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xND+MW/+UJCbTpDVHmrFxQeOX19ZNbbE88mX3i18+R4=;
        b=BELjiJtjShLwwF+3anLAYLL0pDH4nu7aFLQb8fYm78xaRVKg+rx0BFGJX2Pf0PBXSG
         m29DIbJDLmQUQLO0UG8ZjTKUYBGOynGsA5PLewNvG4Lvd/inlzCMsPzzjIIz3P0CDhv1
         aWdqhmp5LGNI2Im/Y1F5LbxaVDl1RIuOvHEJ2wE8pgyZdxTmEAqBr9pZvMbuiG8f9HXN
         vWIdhhRMOJ/VvZLexpjhY813arvZW+Kg7dHtlpvVcjgYzuvtfdGBynFs1NVUTF+Mv+Tx
         obq1XL+clC1/MZSQBewJHKVQiHTDoRFbu8snE28a8fg5ERw7koaXqDzWCLOEnLDGma0b
         pyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696006595; x=1696611395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xND+MW/+UJCbTpDVHmrFxQeOX19ZNbbE88mX3i18+R4=;
        b=ClV4eg/qUnb/cY0ygL0XQpuP/CyUmSjJabbulFspnb4dKFJBJsYm+6judQt52qLmcs
         zRJX9QjLddXiXhIOTKKHfm+mpPwJJpjc9x8H0Lw2D/Z8fQWbeyLRiwzNt1oKnWQuXjWn
         ukLSPMuq7KFHxa5FoWpwwgv/+JMMERlKSYWx4jEu8HGiSX1gXVFfBF6L5VPfcP1DZ16I
         0MA0t7PfUYuRF2p8Dz5VeDJHX29JUkLWp7RYWUdGrgPr1xYdfDoMNicEaPeyEPqd54ay
         x66pBhuPIFVAsklUJPVTl7UCsZgys6GAPPj4Xa0DrDjd2VbchJiKk6Vl8EOpLPrvnY7C
         Y9iA==
X-Gm-Message-State: AOJu0YyxqZJPVuAzlsM5ZhQSLeONBpe37VQNWQ1cKo9xat2BZYQEM+Ox
        sCRw1HEjg58XPRGwDmRwGO6mHQ==
X-Google-Smtp-Source: AGHT+IHL6Thh2nSYg3/7lYJjbnPF19w1qpgTK8doTP2ZGsc7IIv5ssUcTLXHAP1i0i+sB6dIU9sgQg==
X-Received: by 2002:a1c:7c11:0:b0:405:4a78:a890 with SMTP id x17-20020a1c7c11000000b004054a78a890mr4246266wmc.8.1696006594912;
        Fri, 29 Sep 2023 09:56:34 -0700 (PDT)
Received: from [192.168.1.8] (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bcd95000000b00405c7591b09sm1787900wmj.35.2023.09.29.09.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 09:56:34 -0700 (PDT)
Message-ID: <1765d8c7-2f7e-4cb9-9063-f78c5d29e1a4@linaro.org>
Date:   Fri, 29 Sep 2023 17:56:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] thermal: qcom: add qmi-cooling driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20230905-caleb-qmi_cooling-v1-3-5aa39d4164a7@linaro.org>
 <30aa40c9-b63a-093c-954d-86e4bb232431@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <30aa40c9-b63a-093c-954d-86e4bb232431@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29/09/2023 17:28, Konrad Dybcio wrote:
> 
> 
> On 9/29/23 18:16, Caleb Connolly wrote:
>> The Thermal Mitigation Device (TMD) service exposes various platform
>> specific thermal mitigations available on remote subsystems (ie the
>> modem, adsp, cdsp, and sdsp). The service is exposed via the QMI
>> messaging
>> interface, usually over the QRTR transport.
>>
>> These controls affect things like the power limits of the modem power
>> amplifier and cpu core, skin temperature mitigations, as well as rail
>> voltage restrictions under cold conditions.
>>
>> Each remote subsystem has its own TMD instance, where each child node
>> represents a single thermal control.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
> [...]
> 
>> +/* Notify the remote subsystem of the requested cooling state */
>> +static int qmi_tmd_send_state_request(struct qmi_tmd *tmd)
>> +{
>> +    struct tmd_set_mitigation_level_resp_msg_v01 tmd_resp;
>> +    struct tmd_set_mitigation_level_req_msg_v01 req;
>> +    struct qmi_tmd_client *client;
>> +    struct qmi_txn txn;
>> +    int ret = 0;
>> +
>> +    client = tmd->client;
> You can assign it at declaration time

Is this just personal preference or is it subsystem rules? I generally
prefer to avoid non-const assignments at declaration time, it's just
easier to read this way.
>> +
>> +    if (!client->connection_active)
>> +        return 0;
> Is that an expected scenario?

Yes, this function is called by the cooling device set_cur_state op. The
cooling device itself is always registered, even if the remoteproc is
offline (in which case the cached state will be sent to it when it
starts up).
> 
>> +
>> +    memset(&req, 0, sizeof(req));
>> +    memset(&tmd_resp, 0, sizeof(tmd_resp));
> Since you're declaring them above, you can do = { 0 }; instead, which
> will be faster

Thanks, will do (though fwiw the compiler almost definitely optimises
this out).
> 
>> +
>> +    strscpy(req.mitigation_dev_id.mitigation_dev_id, tmd->qmi_name,
>> +        QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
>> +    req.mitigation_level = tmd->cur_state;
>> +
>> +    mutex_lock(&client->mutex);
> Look into fancy scoped mutexes https://lwn.net/Articles/934679/

ooh nice, that actually improves things a lot :D
> 
> [...]
> 
>> +static int qmi_set_cur_state(struct thermal_cooling_device *cdev,
>> unsigned long state)
>> +{
>> +    struct qmi_tmd *tmd = cdev->devdata;
>> +
>> +    if (!tmd)
>> +        return -EINVAL;
>> +
>> +    if (state > tmd->max_state)
>> +        return -EINVAL;Would it be useful if this threw an error in
>> dmesg?

I may be mistaken but I think the only place this will be hit is when
userspace attempts to write to it via sysfs, in that case the invalid
argument is likely enough.
> 
> 
>> + * When the QMI service starts up on a remote subsystem this function
>> will fetch
>> + * the list of TMDs on the subsystem, match it to the TMDs specified
>> in devicetree
>> + * and call qmi_tmd_init_control() for each
>> + */
>> +static void qmi_tmd_svc_arrive(struct work_struct *work)
>> +{
>> +    struct qmi_tmd_client *client =
>> +        container_of(work, struct qmi_tmd_client, svc_arrive_work);
>> +
>> +    struct tmd_get_mitigation_device_list_req_msg_v01 req;
>> +    struct tmd_get_mitigation_device_list_resp_msg_v01 *resp;
>> +    int ret = 0, i;
>> +    struct qmi_txn txn;
>> +
>> +    memset(&req, 0, sizeof(req));
> = { 0 }
> 
> [...]
> 
>> +
>> +    pr_info("QMI TMD service reset %s\n", client->name);
> Is it useful to the user? pr_debug?

Oops, forgot to remove these!
> 
>> +
>> +    list_for_each_entry(tmd, &client->cdev_list, node) {
>> +        qmi_tmd_send_state_request(tmd);
>> +    }
>> +}
>> +
>> +static void thermal_qmi_del_server(struct qmi_handle *qmi, struct
>> qmi_service *service)
>> +{
>> +    struct qmi_tmd_client *client = container_of(qmi, struct
>> qmi_tmd_client, handle);
>> +
>> +    pr_info("QMI TMD service stop %s\n", client->name);
> Ditto
> 
>> +
>> +    client->connection_active = false;
>> +}
>> +
>> +static int thermal_qmi_new_server(struct qmi_handle *qmi, struct
>> qmi_service *service)
>> +{
>> +    struct qmi_tmd_client *client = container_of(qmi, struct
>> qmi_tmd_client, handle);
>> +    struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node,
>> service->port };
>> +
>> +    pr_info("QMI TMD service start %s\n", client->name);
> Ditto
> 
>> +        tmd->type = devm_kasprintf(client->dev, GFP_KERNEL, "%s:%s",
>> +                        client->name, subnode->name);
>> +        if (!tmd->type)
>> +            return dev_err_probe(dev, -ENOMEM, "Cooling device name\n");
> Cooling device name-what? :D

"error -12: Cooling device name"

Maybe this shouldn't print an error at all? I usually just like to have
something to grep for so I don't have to binary search through error
paths when debugging.
> 
>> +
>> +        if (of_property_read_string(subnode, "label", &name)) {
>> +            return dev_err_probe(client->dev, -EINVAL,
>> +                         "Fail to parse dev name for %s\n",
> Failed

ack
> 
> [...]
> 
>> +static int qmi_tmd_client_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev;
>> +    struct qmi_tmd_client *client;
>> +    const struct qmi_instance_id *match;
>> +    int ret;
>> +
>> +    dev = &pdev->dev;
> Initialize at declaration
> 
>> +
>> +    client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
>> +    if (!client)
>> +        return -ENOMEM;
>> +
>> +    client->dev = dev;
>> +
>> +    match = of_device_get_match_data(dev);
>> +    if (!match)
>> +        return dev_err_probe(dev, -EINVAL, "No match data\n");
>> +
>> +    client->id = match->id;
>> +    client->name = match->name;
>> +
>> +    mutex_init(&client->mutex);
>> +    INIT_LIST_HEAD(&client->cdev_list);
>> +    INIT_WORK(&client->svc_arrive_work, qmi_tmd_svc_arrive);
>> +
>> +    ret = qmi_tmd_alloc_cdevs(client);
>> +    if (ret)
>> +        return ret;
>> +
>> +    platform_set_drvdata(pdev, client);
>> +
>> +    ret = qmi_handle_init(&client->handle,
>> +                 
>> TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN,
>> +                  &thermal_qmi_event_ops, NULL);
>> +    if (ret < 0)
>> +        return dev_err_probe(client->dev, ret, "QMI handle init
>> failed for client %#x\n",
>> +                  client->id);
>> +
>> +    ret = qmi_add_lookup(&client->handle, TMD_SERVICE_ID_V01,
>> TMD_SERVICE_VERS_V01,
>> +                 client->id);
>> +    if (ret < 0) {
>> +        qmi_handle_release(&client->handle);
>> +        return dev_err_probe(client->dev, ret, "QMI register failed
>> for client 0x%x\n",
>> +                  client->id);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qmi_tmd_client_remove(struct platform_device *pdev)
> void + .remove_new

Ack
> 
> Konrad

-- 
// Caleb (they/them)
